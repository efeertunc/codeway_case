import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'VideoPlayProvider.dart';

class StoryContentPage extends StatefulWidget {
  final String contentPath;

  StoryContentPage({
    Key? key,
    required this.contentPath,
  }) : super(key: key);

  @override
  _StoryContentPageState createState() => _StoryContentPageState();
}

class _StoryContentPageState extends State<StoryContentPage> {
  @override
  void initState() {
    super.initState();

    if (widget.contentPath.toLowerCase().endsWith('.mp4')) {
      if (context.read<VideoPlayerProvider>().controller?.value.isInitialized ??
          false) {
      } else {
        context.read<VideoPlayerProvider>().initialize(widget.contentPath);
      }
    } else {
      context.read<VideoPlayerProvider>().disposeController();
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.contentPath.toLowerCase().endsWith('.mp4')) {
      return Consumer<VideoPlayerProvider>(
        builder: (_, provider, __) => AspectRatio(
          aspectRatio: provider.controller!.value.aspectRatio,
          child: VideoPlayer(provider.controller!),
        ),
      );
    } else {
      return Center(
          child: Image.network(widget.contentPath, fit: BoxFit.fitWidth));
    }
  }
}
