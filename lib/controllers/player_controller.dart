import 'package:get/get.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:symphoo/components/permission_dialog.dart';
import 'package:symphoo/controllers/permission_controller.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  var permissionController = Get.put(PermissionController());

  checkPermission(context) async {
    var permission = await permissionController.checkPermission(context);
    if (permission == false || permissionController.hasStoragePermission == false) {
      await showPermissionDialog(context);
    }
    else {
      var data = await audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
      );
      return data;
      
    }
  }

  
}
