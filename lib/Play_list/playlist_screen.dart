import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_project/Play_list/playlist_folder.dart';
import 'package:music_project/Play_list/play_list_function.dart';

import 'package:music_project/db/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';
import '../home/costom widgets/add_remove_button.dart';
import '../home/costom widgets/customs.dart';
import '../home/home_view/home_screen.dart';

class PlaylistScreen extends GetView {
  PlaylistScreen({Key? key}) : super(key: key);

  final namecontroller = TextEditingController();
  static List<dynamic> selectionList = [];

  @override
  Widget build(BuildContext context) {
    Playlistfunction.displayplaylist();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: PreferredSize(
        child: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: TitleName(name: 'Playlist'),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 20),
              child: InkWell(
                onTap: () {
                  showModalBottomSheet(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
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
                          child: Center(
                            child: Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 20, right: 20, left: 20),
                                  child: TextField(
                                    controller: namecontroller,
                                    decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        suffixIcon: InkWell(
                                            onTap: () async {
                                              final foldername =
                                                  namecontroller.text;
                                              final modelM = MusicModel(
                                                  name: foldername,
                                                  songlistdb: PlaylistScreen
                                                      .selectionList);
                                              await Playlistfunction
                                                  .addplaylist(model: modelM);
                                              namecontroller.clear();
                                              PlaylistScreen.selectionList
                                                  .clear();
                                              Navigator.pop(context);
                                            },
                                            child: const Icon(
                                              Icons.save,
                                              color:
                                                  Color.fromARGB(255, 0, 0, 0),
                                              size: 30,
                                            )),
                                        hintText: '    Create Playlist',
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                  ),
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
                                            trailing:
                                                AddRemoveButton(index: index),
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
                          ),
                        );
                      });
                },
                child: const Icon(
                  Icons.note_add_outlined,
                  color: Colors.white,
                  size: 30,
                ),
              ),
            )
          ],
        ),
        preferredSize: const Size.fromHeight(80),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
        child: Obx(
          () {
            builder:
            return GridView.builder(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 200,
                childAspectRatio: 3 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
              ),
              itemCount: Playlistfunction.listplaysong.length,
              itemBuilder: (BuildContext context, index) {
                return InkWell(
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            PlaylistFolder(folderindex: index)));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      image: const DecorationImage(
                        image: AssetImage(
                          'lib/assets/playlist.jpg',
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Column(
                      children: [
                        Container(
                          height: 30,
                          width: 100,
                          decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              color: Colors.white),
                          child: Center(
                              child: Text(
                            Playlistfunction.listplaysong[index].name
                                .toString(),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 0, 0, 0),
                                fontFamily: 'colonnamt',
                                fontSize: 20),
                          )),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 95,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                            backgroundColor: Colors.white,
                                            title: const Text(
                                              'Remove this playlist ',
                                              style: TextStyle(
                                                  fontFamily: 'colonnamt',
                                                  fontSize: 20),
                                            ),
                                            content: Container(
                                              height: 40,
                                              width: 300,
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(30),
                                                  color: const Color.fromARGB(
                                                      255, 0, 0, 0)),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
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
                                                              255,
                                                              255,
                                                              255,
                                                              255)),
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 60,
                                                    width: 5,
                                                    decoration:
                                                        const BoxDecoration(
                                                            color:
                                                                Colors.white),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Playlistfunction
                                                          .deleteplaylist(
                                                              index);
                                                      Navigator.pop(context);
                                                    },
                                                    child: const Text(
                                                      'Ok',
                                                      style: TextStyle(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
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
                                    color: Color.fromARGB(255, 165, 0, 0),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
