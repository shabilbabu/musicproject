import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_project/home/costom%20widgets/customs.dart';
import 'package:music_project/now_playing/controller/now_palying_controller.dart';
import 'package:music_project/db/favorites/controller/favourite_function.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../concatinating.dart';
import '../../now_playing/now_playing_view/now_playing.dart';


class FavouriteScreen extends GetView <FavouriteData>{
   FavouriteScreen({Key? key}) : super(key: key);

  final nowplayingcontroller = Get.put(NowPlayinController());
  final dbfun = Get.put(FavouriteData());
  @override
  Widget build(BuildContext context) {
    dbfun.getfavouritelist();

    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TitleName(name: 'Favourite Songs')
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GetBuilder<FavouriteData>(
          init: FavouriteData(),
          
          builder: (controller) {
            
          
            return ListView.separated(
              itemCount: dbfun.favsongmodellist.length,
              separatorBuilder: (BuildContext context, int index) =>
                  const Divider(
                thickness: 1,
                indent: 90,
                endIndent: 18,
                color: Colors.white,
              ),
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                  onTap: () {
                    nowplayingcontroller.player.setAudioSource(
                        Concatinating.createPlaylist(
                            dbfun.favsongmodellist),
                        initialIndex: index);
                    nowplayingcontroller.player.play();

                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => NowPlaying(
                        

                              songList: dbfun.favsongmodellist,
                            ))
                            );
                  },
                  title: Text(
                    // HomeScreen.songs[dbfun.favouritesong[index]].title,
                     dbfun.favsongmodellist[index].title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white),
                  ),
                  subtitle: Text(
                      dbfun.favsongmodellist[index].artist.toString(),
                    style: const TextStyle(color: Color.fromARGB(255, 207, 207, 207)),
                  ),
                  // trailing:  FavouritButton(index: index),
                  leading: QueryArtworkWidget(
                      // id: HomeScreen.songs[dbfun.favouritesong[index]].id,
                      id: dbfun.favsongmodellist[index].id,
                      type: ArtworkType.AUDIO),
                  trailing: IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                                backgroundColor: Colors.white,
                                title: const Text(
                                  'Remove from favourite ',
                                  style:  TextStyle(
                                      fontFamily: 'colonnamt', fontSize: 20),
                                ),
                                content: Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color: const Color.fromARGB(255, 0, 0, 0)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Cancel',
                                          style:  TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        width: 5,
                                        decoration:
                                            const BoxDecoration(color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          dbfun.removelist(index);
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Ok',
                                          style:  TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color:  Color.fromARGB(
                                                  255, 206, 18, 5)),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.delete,
                        color:  Color.fromARGB(255, 142, 142, 142),
                      )),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
