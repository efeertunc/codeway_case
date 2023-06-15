import 'dart:async';

import 'package:codeway_case/view/VideoPlayProvider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class AutoPlayVideoPlayer extends StatefulWidget {
  final String url;
  final Stream<bool> playPauseStream;

  AutoPlayVideoPlayer(
      {Key? key, required this.url, required this.playPauseStream})
      : super(key: key);

  @override
  _AutoPlayVideoPlayerState createState() => _AutoPlayVideoPlayerState();
}

class _AutoPlayVideoPlayerState extends State<AutoPlayVideoPlayer> {
  late StreamSubscription<bool> playPauseSubscription;

  @override
  void initState() {
    super.initState();

    playPauseSubscription = widget.playPauseStream.listen((play) {
      context.read<VideoPlayerProvider>().playPause(play);
    });

    context.read<VideoPlayerProvider>().initialize(widget.url);
  }

  @override
  void dispose() {
    playPauseSubscription.cancel(); // cancel the subscription when disposing the widget
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<VideoPlayerProvider>(
      builder: (_, provider, __) => StreamBuilder<Object>(
        stream: widget.playPauseStream,
        initialData: true,
        builder: (context, snapshot) {
          print("sjkandksjank" + snapshot.data.toString());
          return AspectRatio(
            aspectRatio: provider.controller.value.aspectRatio,
            child: VideoPlayer(provider.controller),
          );
        },
      ),
    );
  }
}
