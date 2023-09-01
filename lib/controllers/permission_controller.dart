import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:permission_handler/permission_handler.dart';


class PermissionController extends GetxController with WidgetsBindingObserver {
  bool hasStoragePermission = false;

  @override
  onInit() {
    super.onInit();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void onClose() {
    WidgetsBinding.instance.removeObserver(this);
    super.onClose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed &&
        await Permission.storage.isGranted) {      
      hasStoragePermission = true;
      update();
    }
  }
  
  checkPermission(context) async {
    try {
      var request = await Permission.storage.request();
      var status = await Permission.storage.status;
      if (request.isGranted || status == PermissionStatus.granted) {
        hasStoragePermission = true;
        return true;
      } else  {
        return false;
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}

