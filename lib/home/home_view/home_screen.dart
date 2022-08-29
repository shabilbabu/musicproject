import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:music_project/concatinating.dart';
import 'package:music_project/home/controller/home_controller.dart';
import 'package:music_project/now_playing/controller/now_palying_controller.dart';
import 'package:music_project/now_playing/now_playing_view/now_playing.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../costom widgets/customs.dart';



class HomeScreen extends GetView <HomeController>{
  HomeScreen({Key? key}) : super(key: key);

  //this is all songs
  static List<SongModel> songs = [];

  final homecontroller = Get.put(HomeController());
  final nowplaycontroller = Get.put(NowPlayinController());
  // @override
  // void initState() {
  //   super.initState();
  //   storageRequestpermission();
  // }

  // String currentSongTitle = '';
  //int currentIndex = 0;

  @override
  Widget build(BuildContext context) {

    //FavouriteData.songsshow();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: TitleName(name: 'Musics'),
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
        return FutureBuilder<List<SongModel>>(
            future: controller.audioQuery.querySongs(
                orderType: OrderType.ASC_OR_SMALLER,
                uriType: UriType.EXTERNAL,
                ignoreCase: true),
            builder: (context, item) {
              if (item.data == null) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              if (item.data!.isEmpty) {
                return Center(
                  child: Text(
                    'No Songs',
                    style: TextStyle(
                        fontSize: 22.sp,
                        fontFamily: 'colonnamt',
                        color: Colors.white),
                  ),
                );
              }
              HomeScreen.songs = item.data!;
              return ListView.builder(
                  itemCount: item.data!.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                      margin:
                          EdgeInsets.only(top: 15.h, left: 15.r, right: 16.r),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.black.withOpacity(0.5)),
                      child: InkWell(
                        onTap: () async {
                          
                          Get.to(() => NowPlaying(songList:item.data!,));
                          // Navigator.of(context).push(MaterialPageRoute(
                          //     builder: (ctx) =>
                          //         PlayScreen(pattu: HomeScreen.songs)));
                          
                          await nowplaycontroller.player.setAudioSource(
                              Concatinating.createPlaylist(HomeScreen.songs),
                              initialIndex: index);
                          await nowplaycontroller.player.play();
                        },
                        child:
                            ListTileModel(index: index, songslist: item.data),
                      ),
                    );
                  });
            });
      }),
    );
  }

  // void storageRequestpermission() async {
  //   if (!kIsWeb) {
  //     bool permissionStatus = await _audioQuery.permissionsStatus();
  //     if (!permissionStatus) {
  //       await _audioQuery.permissionsRequest();
  //     }
  //     setState(() {});
  //   }
  // }
}
