import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../db/favorites/controller/favourite_function.dart';

class homefavorite extends GetView {
  homefavorite({Key? key,required this.id}) : super(key: key);
  dynamic id;

 

  final favcontro = Get.put(FavouriteData());
  @override
  Widget build(BuildContext context) {
    final indexfinding = favcontro.listDB.contains(id);
    if (indexfinding == true) {
      return IconButton(
          onPressed: () async {
            final checkindex =favcontro.listDB.indexWhere((element)=>element == id);
           await favcontro.removelist(checkindex);
            
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ));
    } else {
      return IconButton(
          onPressed: () async{
            await favcontro.addfavouritesong(id);
            
          },
          icon: const Icon(
            Icons.favorite_border_outlined,
            color: Color.fromARGB(255, 255, 255, 255),
          ));
    }
  }
}