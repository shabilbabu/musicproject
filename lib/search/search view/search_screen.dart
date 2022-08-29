import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:music_project/home/home_view/home_screen.dart';
import 'package:music_project/now_playing/now_playing_view/now_playing.dart';
import 'package:music_project/search/controller/search_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class SearchScreen extends GetView<SearchController> {
  SearchScreen({Key? key}) : super(key: key);

  final serchcontroller = Get.put(SearchController());

  static dynamic searchindex = [];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              title: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: TextField(
                  onChanged: (String value) {
                    serchcontroller.searchFilter(value);
                  },
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    prefixIcon: const Icon(
                      Icons.search_rounded,
                      size: 25,
                      color: Colors.black,
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Search Songs',
                  ),
                ),
              ),
            ),
            body: SafeArea(
                child: ListView(
              children: [
                Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 1,
                      child: Obx(() {
                        return ListView.builder(
                            itemCount: serchcontroller.temp.length,
                            itemBuilder: (context, index) {
                              final data = serchcontroller.temp[index];
                              return Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: SizedBox(
                                  height: 50,
                                  child: ListTile(
                                    leading: QueryArtworkWidget(
                                        artworkWidth: 50,
                                        artworkBorder:
                                            BorderRadius.circular(800),
                                        artworkFit: BoxFit.cover,
                                        id: data.id,
                                        type: ArtworkType.AUDIO),
                                    title: Text(
                                      data.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                    onTap: () async {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) => NowPlaying(
                                                  songList: HomeScreen.songs)));
                                    },
                                  ),
                                ),
                              );
                            });
                      }),
                    )
                  ],
                )
              ],
            ))),
      ),
    );
  }

  ConcatenatingAudioSource createPlaylist(List<SongModel> songs) {
    List<AudioSource> sources = [];
    for (var song in songs) {
      sources.add(AudioSource.uri(Uri.parse(
        song.uri!,
      )));
    }
    return ConcatenatingAudioSource(children: sources);
  }
}
