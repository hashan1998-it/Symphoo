import 'package:get/get.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:symphoo/components/permission_dialog.dart';
import 'package:symphoo/controllers/permission_controller.dart';

class PlayerController extends GetxController {
  final audioQuery = OnAudioQuery();
  final audioPlayer = AudioPlayer();

  RxInt playIndex = 0.obs;
  RxBool isPlaying = false.obs;

  var permissionController = Get.put(PermissionController());

  playSong(String? uri,index) async {
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.play();
      isPlaying.value = true;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  pauseSong(String? uri,index) async{
    playIndex.value = index;
    try {
      audioPlayer.setAudioSource(AudioSource.uri(Uri.parse(uri!)));
      audioPlayer.pause();
      isPlaying.value = false;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  //NOTE - This is the function that is called in the home.dart file
  checkPermission(context) async {
    var permission = await permissionController.checkPermission(context);
    if (permission == false ||
        permissionController.hasStoragePermission == false) {
      await showPermissionDialog(context);
    } else {
      var data = await audioQuery.querySongs(
        sortType: null,
        orderType: OrderType.ASC_OR_SMALLER,
      );
      return data;
    }
  }
}
