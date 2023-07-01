import 'package:flutter/cupertino.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerProvider with ChangeNotifier {
  VideoPlayerController? controller;
  late Future<void> initializeVideoPlayer;

  void initialize(String url) {
    controller = VideoPlayerController.network(url);
    initializeVideoPlayer = controller!.initialize().then((_) {
      controller!.setLooping(false);
      notifyListeners();
    }).catchError((error) {
      print("Error initializing video player: $error");
    });
  }

  void playPause(bool play) {
    if (controller!.value.isInitialized) {
      if (play) {
        if (!controller!.value.isPlaying) {
          controller!.play();
          notifyListeners();
        }
      } else {
        controller!.pause();
        notifyListeners();
      }
    }
  }

  void disposeController() {
    if (controller != null) {
      controller!.pause();
    }
  }
}
