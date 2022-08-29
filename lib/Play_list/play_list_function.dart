import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_project/home/home_view/home_screen.dart';
import 'package:music_project/db/data_model.dart';
import 'package:on_audio_query/on_audio_query.dart';


class Playlistfunction extends GetxController{
  static RxList listplaysong = [].obs;
  static var playlistsongmodel = <SongModel>[].obs;
  static List<dynamic> idees = [].obs;

  static addplaylist({required MusicModel model}) async {

    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');

    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');

    await playlistDB.add(model);

    var hello = model.songlistdb.toList();

    await playlistsongDB.add(hello); 

    displayplaylist();
  }



  static displayplaylist() async {

    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');

    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');

    listplaysong.clear();

    idees.clear();

    listplaysong.addAll(playlistDB.values);

    var hey = playlistsongDB.values.toList();

    idees = hey;
  }



  static deleteplaylist(index) async {

    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');

    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');

    await playlistDB.deleteAt(index);

    await playlistsongDB.deleteAt(index);

    await displayplaylist();
  }



  static updatePlaylist(index, MusicModel model) async {

    final playlistDB = await Hive.openBox<MusicModel>('music_model_DB');

    final playlistsongDB = await Hive.openBox<dynamic>('music_model_song_DB');

     var hey = model.songlistdb.toList();

     await playlistDB.putAt(index,model);

     await playlistsongDB.putAt(index, hey);

     displayplaylist();
  }
}






class SongCheckPlaylist {

   static ValueNotifier<List> selectsong = ValueNotifier([]);


  static showselectedsong(index) {

    final checksong = Playlistfunction.idees[index];

    selectsong.value.clear();

    Playlistfunction.playlistsongmodel.clear();

    for (int i = 0; i < checksong.length; i++) {
      for (int j = 0; j < HomeScreen.songs.length; j++) {


        if (HomeScreen.songs[j].id == checksong[i]) {

          selectsong.value.add(j);
          
          Playlistfunction.playlistsongmodel.add(HomeScreen.songs[j]);

          break;
        }
      }
    }
    selectsong.notifyListeners();
  }
}
