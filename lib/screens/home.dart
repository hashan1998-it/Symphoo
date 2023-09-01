import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:symphoo/constants/colors.dart';
import 'package:symphoo/constants/text_style.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:symphoo/controllers/player_controller.dart';
import 'package:symphoo/controllers/permission_controller.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //!Initilize controllers
  var playerController = Get.put(PlayerController());
  var permissionController = Get.put(PermissionController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bgcolor,
      appBar: AppBar(
        title: Text('Symphoo', style: textStyle(fontWeight: bold)),
        leading: const Icon(Icons.sort_outlined, color: Colors.black),
        actions: const [
          Icon(Icons.search, color: Colors.black),
          SizedBox(width: 20),
          Icon(Icons.notifications_outlined, color: Colors.black),
          SizedBox(width: 20),
        ],
      ),
      body: FutureBuilder(
        //!Future controllers
        future: playerController.checkPermission(context),
        builder: (context, snapshot) {
          //!Check if snapshot has data
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData == false) {
            return const Center(
              child: Text('No songs found'),
            );
          } else if (snapshot.hasData == true) {
            var data = snapshot.data as List<SongModel>;

            return SongList(data: data);
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}



class SongList extends StatelessWidget {
  const SongList({
    super.key,
    required this.data,
  });

  final List<SongModel> data;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return Container(

          margin:
              const EdgeInsets.symmetric(horizontal: 20, vertical: 8),

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
          ),

          child: ListTile(

            leading: const Icon(
              Icons.music_note,
              size: 32,
            ),

            title: Text(
              //?If artist is null then show unknown
              data[index].displayNameWOExt,
              style: const TextStyle(fontWeight: normal, fontSize: 15),
            ),

            subtitle: Text(
              //?If artist is null then show unknown
              data[index].artist ?? 'Unknown',
              style: const TextStyle(
                  fontWeight: FontWeight.w200, fontSize: 12),
            ),

            trailing: const Icon(Icons.play_circle),

          ),
        );
      },
      itemCount: data.length,
    );
  }
}
