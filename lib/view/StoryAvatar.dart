import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class StoryAvatar extends StatefulWidget {
  final String imageUrl;

  StoryAvatar({required this.imageUrl});

  @override
  _StoryAvatarState createState() => _StoryAvatarState();
}

class _StoryAvatarState extends State<StoryAvatar> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Card(
              color: Colors.blueGrey,
              shape: CircleBorder(),
              elevation: 5.0,
              child: Container(
                width: 82.0,
                height: 82.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft,
                    colors: [
                      Color.fromRGBO(243, 18, 119, 1.0),
                      Color.fromRGBO(129, 52, 175, 1.0),
                      Color.fromRGBO(236, 28, 117, 1.0),
                      Color.fromRGBO(245, 133, 41, 1.0),
                      Color.fromRGBO(254, 218, 119, 1.0),
                    ],
                  ),
                ),
                padding: const EdgeInsets.all(3), // border width
                child: ClipOval(
                  child: Image.network(
                    widget.imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          Text("efertunc"),
        ],
      ),
    );
  }
}
