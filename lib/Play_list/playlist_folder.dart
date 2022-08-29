import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_project/Play_list/play_list_function.dart';
import 'package:music_project/home/home_view/home_screen.dart';
import 'package:music_project/now_playing/controller/now_palying_controller.dart';
import 'package:music_project/now_playing/now_playing_view/now_playing.dart';
import 'package:music_project/db/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../concatinating.dart';
import '../home/costom widgets/update_remove_button.dart';

class PlaylistFolder extends GetView<Playlistfunction> {
  PlaylistFolder({Key? key, required this.folderindex}) : super(key: key);
  final int folderindex;
  static List<dynamic> updatelist = [];

  final NowPlayinController nowplayingcontroller = Get.find();

  @override
  Widget build(BuildContext context) {
    updatelist = Playlistfunction.idees[folderindex];
    Playlistfunction.displayplaylist();
    SongCheckPlaylist.showselectedsong(folderindex);
    return Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.centerRight,
                end: Alignment.centerLeft,
                colors: [
              Colors.black,
              Color.fromARGB(255, 165, 165, 165),
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Playlistfunction.listplaysong[folderindex].name.toString(),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'colonnamt', fontSize: 30),
                ),
                IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        context: context,
                        builder: (BuildContext context) {
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: const LinearGradient(
                                begin: Alignment.centerRight,
                                end: Alignment.centerLeft,
                                colors: [
                                  Colors.black,
                                  Color.fromARGB(255, 165, 165, 165),
                                ],
                              ),
                            ),
                            child: Column(
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: IconButton(
                                      onPressed: () {
                                        final model = MusicModel(
                                            name: Playlistfunction
                                                .listplaysong[folderindex].name,
                                            songlistdb:
                                                PlaylistFolder.updatelist);
                                        Playlistfunction.updatePlaylist(
                                            folderindex, model);
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.save,
                                        color: Colors.white,
                                        size: 30,
                                      )),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 20),
                                    child: ListView.separated(
                                        itemCount: HomeScreen.songs.length,
                                        separatorBuilder:
                                            (BuildContext context, int index) =>
                                                const Divider(
                                                  color: Colors.white,
                                                  indent: 18,
                                                  endIndent: 18,
                                                  height: 20,
                                                ),
                                        itemBuilder:
                                            (BuildContext context, int index) {
                                          return ListTile(
                                            title: Text(
                                              HomeScreen.songs[index].title,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            subtitle: Text(
                                              HomeScreen.songs[index].artist!,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            trailing: UpdateAddRemoveButton(
                                                index: index),
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(500),
                                              child: QueryArtworkWidget(
                                                id: HomeScreen.songs[index].id,
                                                type: ArtworkType.AUDIO,
                                                artworkBorder:
                                                    BorderRadius.circular(
                                                        150.0),
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                )
                              ],
                            ),
                          );
                        });
                  },
                  icon: const Icon(Icons.add_box_outlined),
                ),
              ],
            ),
          ),
          body: ListView.separated(
              separatorBuilder: (context, index) => const Divider(
                    thickness: 1,
                    color: Colors.white,
                  ),
              itemCount: SongCheckPlaylist.selectsong.value.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(
                    onTap: () {
                      nowplayingcontroller.player.setAudioSource(
                          Concatinating.createPlaylist(
                              Playlistfunction.playlistsongmodel),
                          initialIndex: index);
                      nowplayingcontroller.player.play();

                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => NowPlaying(
                                songList:
                                    Playlistfunction.playlistsongmodel.value,
                              )));
                    },
                    title: Text(
                      HomeScreen
                          .songs[SongCheckPlaylist.selectsong.value[index]]
                          .title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(color: Colors.white),
                    ),
                    subtitle: Text(
                      HomeScreen
                          .songs[SongCheckPlaylist.selectsong.value[index]]
                          .artist
                          .toString(),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
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
                                  'Remove song from playlist ',
                                  style: TextStyle(
                                      fontFamily: 'colonnamt', fontSize: 20),
                                ),
                                content: Container(
                                  height: 40,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(30),
                                      color:
                                          const Color.fromARGB(255, 0, 0, 0)),
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
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: Color.fromARGB(
                                                  255, 255, 255, 255)),
                                        ),
                                      ),
                                      Container(
                                        height: 60,
                                        width: 5,
                                        decoration: const BoxDecoration(
                                            color: Colors.white),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text(
                                          'Ok',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              color: Color.fromARGB(
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
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    leading: QueryArtworkWidget(
                        id: HomeScreen
                            .songs[SongCheckPlaylist.selectsong.value[index]]
                            .id,
                        type: ArtworkType.AUDIO));
              }),
        ));
  }
}
