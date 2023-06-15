import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:flutter/cupertino.dart';

class VideoPlayerProvider with ChangeNotifier {
  late VideoPlayerController controller;
  late Future<void> initializeVideoPlayer;

  void initialize(String url) {
    controller = VideoPlayerController.network(url);
    initializeVideoPlayer = controller.initialize().then((_) {
      controller.play();
      notifyListeners();
    }).catchError((error) {
      print("Error initializing video player: $error");
    });
  }

  void playPause(bool play) {
    if (controller.value.isInitialized) {
      if (play) {
        if (!controller.value.isPlaying) {
          controller.play();
          notifyListeners();
        }
      } else {
        controller.pause();
        notifyListeners();
      }
    }
  }

  void disposeController() {
    controller.dispose();
  }
}