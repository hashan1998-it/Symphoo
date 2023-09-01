import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:symphoo/screens/home.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:symphoo/controllers/permission_controller.dart';

Future<void> showPermissionDialog(context) async {
  return showDialog<void>(
    context: context,

    //! Dialog cannot be dismissed by tapping outside
    barrierDismissible: false,
    builder: (BuildContext context) {
      return GetBuilder<PermissionController>(
        init: PermissionController(),
        builder: (controller) {
          if (controller.hasStoragePermission == false) {
            return const PermissionDialogBox(
              permissionTitle: 'Permission Required',
              permissionContent: 'You have to obtain permission',
              isgranted: false,
            );
          } else {
            return const PermissionDialogBox(
              permissionTitle: 'Permission Granted',
              permissionContent: 'You have to obtain permission',
              isgranted: true,
            );
          }
        },
      );
    },
  );
}

class PermissionDialogBox extends StatelessWidget {
  final String permissionTitle;
  final String permissionContent;
  final bool isgranted;

  const PermissionDialogBox({
    super.key,
    required this.permissionTitle,
    required this.permissionContent,
    required this.isgranted,
  });

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      //!title of the dialog
      title: Text(permissionTitle),

      //!content dialog
      content: Text(permissionContent),

      //!actions
      actions: !isgranted
          ? <Widget>[
              CupertinoDialogAction(
                child: const Text('No'),
                onPressed: () {
                  //!When pressed it close app
                  SystemChannels.platform.invokeMethod('SystemNavigator.pop');
                },
              ),
              CupertinoDialogAction(
                //!when click it opens settings
                isDefaultAction: true,
                child: const Text('Open Settings'),
                onPressed: () async {
                  openAppSettings();
                },
              ),
            ]
          : <Widget>[
              CupertinoDialogAction(
                //!when click refreshes the page
                isDefaultAction: true,
                child: const Text('OK'),
                onPressed: () async {
                  Get.offAll(const Home());
                },
              ),
            ],
    );
  }
}
