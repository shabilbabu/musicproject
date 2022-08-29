import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';


class NowPlayinController extends GetxController{
  //List<SongModel>? playingDetails = [];
  final AudioPlayer player = AudioPlayer();

   bool shufflecheck=false;
  

  @override
  void onInit() {
    //playingDetails!.clear();
    // for(var i = 0; i < playingDetails!.length; i++){
    //   NowPlaying.songList.add(playingDetails![i]);
      
      
    // }
    
super.onInit();
    player.currentIndexStream.listen((index) { 
      if(index != null){
        update();
      }
    });
  } 
  

  // void _updateCurrentPlayingSongDetails(int index) {
    
  //     if (HomeScreen.songs.isNotEmpty) {
  //       currentSongTitle = Now_Playing.songList[index].title;
  //       currentIndex = index;
  //     }
    
  // }
}