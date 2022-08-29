import 'package:flutter/material.dart';

import '../../Play_list/playlist_screen.dart';
import '../home_view/home_screen.dart';

class AddRemoveButton extends StatefulWidget {
  AddRemoveButton({Key? key, required this.index}) : super(key: key);

  final dynamic index;

  @override
  State<AddRemoveButton> createState() => _AddRemoveButtonState();
}

class _AddRemoveButtonState extends State<AddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    final checkindex = PlaylistScreen.selectionList
        .indexWhere((element) => element == HomeScreen.songs[widget.index].id);
    final check = PlaylistScreen.selectionList
        .contains(HomeScreen.songs[widget.index].id);
    if (check == true) {
      return IconButton(
          onPressed: () async {
            await PlaylistScreen.selectionList.removeAt(checkindex);
            setState(() {});
          },
          icon: const Icon(
            Icons.remove_circle_outline_outlined,
            color: Colors.white,
          ));
    }
    return IconButton(
        onPressed: () {
          PlaylistScreen.selectionList.add(HomeScreen.songs[widget.index].id);
          setState(() {});
        },
        icon: const Icon(
          Icons.add_circle,
          color: Colors.white,
        ));
  }
}