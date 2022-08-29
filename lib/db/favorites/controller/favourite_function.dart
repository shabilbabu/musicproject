
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:music_project/home/home_view/home_screen.dart';
import 'package:on_audio_query/on_audio_query.dart';

class FavouriteData extends GetxController{
 // static ValueNotifier<List> favouritesong = ValueNotifier([]);
//  List favouritesong = [];
//    List favouritelist = [];
   List<SongModel> favsongmodellist = [];
   List<dynamic> listDB=[];

   addfavouritesong(value) async {
    final favDB = await Hive.openBox('fav_db');
    await favDB.add(value);
    getfavouritelist();
  }

   getfavouritelist() async {
    final favDB = await Hive.openBox('fav_db');
    listDB = favDB.values.toList();
    songsshow();
  }

   songsshow() async {
    final favDB = await Hive.openBox('fav_db');
    // favouritesong.clear();
    favsongmodellist.clear();
    for (int i = 0; i < listDB.length; i++) {
      for (int j = 0; j < HomeScreen.songs.length; j++) {
        if (HomeScreen.songs[j].id == listDB[i]) {
          // favouritesong.add(j);
          favsongmodellist.add(HomeScreen.songs[j]);
        }
      }
    }
    update();
    // favouritesong.notifyListeners();
  }

   removelist(index) async {
    final favDB = await Hive.openBox('fav_db');
    await favDB.deleteAt(index);
    getfavouritelist();
  }
}
