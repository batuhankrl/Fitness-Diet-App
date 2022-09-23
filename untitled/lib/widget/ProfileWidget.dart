
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:untitled/theme/colors.dart';

class ProfileWidget extends StatelessWidget {
  final String imagePath;
  final VoidCallback onClicked;

  const ProfileWidget({
    Key? key,
    required this.imagePath,
    required this.onClicked,

  }):super(key: key);

  @override
  Widget build(BuildContext context) {
    final color=Theme.of(context).colorScheme.primary;
    return Center(
      child: Stack
        (
        children: [
          buildImage(),
          Positioned(
              bottom: 0,
              right: 4,
              child: buildEditButton(color)),
        ],
      ),
    );

  }
  Widget buildImage(){
    final image=NetworkImage(imagePath);

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image:image,
          fit:BoxFit.cover,
          width: 128,
          height:128,
          child: InkWell(onTap: onClicked),
        ),
      ),
    );
  }

  Widget buildEditButton(Color color)=>buildCircle(
    color: Colors.white,
    all: 3,
    child: buildCircle(
      color:white,
      all:8,
      child: const Icon(
        Icons.edit,
        color: web,
        size:25,
      ),
    ),
  );
  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  })=> ClipOval(
    child: Container(
      padding: EdgeInsets.all(all),

      child: child,
      color: color,

    ),
  );
}