import 'package:get/get.dart';
import 'package:music_project/home/home_view/home_screen.dart';

class SearchController extends GetxController{
  RxList  temp = [].obs;
  

  searchFilter(String Value){
    if(Value.isEmpty){
      temp.addAll(HomeScreen.songs);
    }else{
      temp.value = HomeScreen.songs.where((song) => song.title.toLowerCase().startsWith(Value.toLowerCase())).toList();
    }

  }
}