import 'package:flutter/material.dart';

import '../../Play_list/playlist_folder.dart';
import '../home_view/home_screen.dart';

class UpdateAddRemoveButton extends StatefulWidget {
  const UpdateAddRemoveButton({Key? key, required this.index})
      : super(key: key);
  final dynamic index;

  @override
  State<UpdateAddRemoveButton> createState() => _UpdateAddRemoveButtonState();
}

class _UpdateAddRemoveButtonState extends State<UpdateAddRemoveButton> {
  @override
  Widget build(BuildContext context) {
    final check =
        PlaylistFolder.updatelist.contains(HomeScreen.songs[widget.index].id);
    if (check == true) {
      return IconButton(
          onPressed: () async {
            final checkindex = await PlaylistFolder.updatelist.indexWhere(
                (element) => element == HomeScreen.songs[widget.index].id);
            await PlaylistFolder.updatelist.removeAt(checkindex);
            setState(() {});
          },
          icon: const Icon( 
            Icons.remove_circle_outline_outlined,
            color: Colors.white,
          ));
    }
    return IconButton(
        onPressed: () {
          PlaylistFolder.updatelist.add(HomeScreen.songs[widget.index].id);
          setState(() {});
        },
        icon: const Icon(
          Icons.add_circle,
          color: Colors.white,
        ));
  }
}