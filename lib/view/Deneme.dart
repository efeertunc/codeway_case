import 'dart:async';

import 'package:appinio_video_player/appinio_video_player.dart';
import 'package:codeway_case/view/VideoPlayProvider.dart';
import 'package:codeway_case/view/cubit/StoryViewModel.dart';
import 'package:codeway_case/view/model/Story.dart';
import 'package:codeway_case/view/repo/StoryRepository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

import 'AutoPlayVideoPlayer.dart';
import 'VideoPlayerMethods.dart';

class Deneme extends StatefulWidget {
  int profileIndex = 0;

  Deneme(int index) {
    this.profileIndex = index;
  }

  @override
  _Deneme createState() => _Deneme();
}

class _Deneme extends State<Deneme> {
  List<PageController> pageControllers = [];
  List<int> currentIndexes = [];
  PageController parentPageController = PageController();
  StreamController<bool> playPauseController =
  StreamController<bool>.broadcast();

  @override
  void initState() {
    super.initState();
    context.read<StoryViewModel>().getStories();
  }

  @override
  void dispose() {
    super.dispose();
    // playPauseController.close();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<StoryViewModel, StoryData>(
        builder: (context, storyData) {
          if (storyData.connectionState == ConnectionState.done) {
            if (storyData.storyList.isNotEmpty) {
              var iterator = storyData.storyList.iterator;
              List<Widget> pageChildren = [];
              int pageIndex = 0;

              while (iterator.moveNext()) {
                pageControllers.add(PageController());
                currentIndexes.add(0);
                Story currentStory = iterator.current;
                pageChildren.add(
                  wBuildStoryPage(currentStory.stories!, pageIndex, storyData),
                );
                pageIndex++;
              }

              return PageView(
                controller: parentPageController,
                scrollDirection: Axis.horizontal,
                allowImplicitScrolling: true,
                children: pageChildren,
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

  wBuildStoryPage(
      List<String> userStoryList, int pageIndex, StoryData storyData) {
    return GestureDetector(
      onLongPressStart: (_) {
        print("aaa");
        context.read<VideoPlayerProvider>().playPause(false);
      },
      onLongPressEnd: (_) {
        print("bbb");
        context.read<VideoPlayerProvider>().playPause(true);// Resume video when long press ends
      },
      child: Stack(
        children: [
          PageView.builder(
            controller: pageControllers[pageIndex],
            itemCount: userStoryList.length,
            pageSnapping: false,
            allowImplicitScrolling: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              if (userStoryList[currentIndexes[pageIndex]]
                  .toLowerCase()
                  .endsWith('.mp4')) {
                  return AutoPlayVideoPlayer(
                      url: userStoryList[currentIndexes[pageIndex]],
                      playPauseStream: playPauseController.stream);

              } else {
                return Image.network(userStoryList[currentIndexes[pageIndex]],
                    fit: BoxFit.fitWidth);
              }
            },
            onPageChanged: (index) {
              setState(() {
                currentIndexes[pageIndex] = index;
              });
            },
          ),
          GestureDetector(
            onTap: () {
              if (currentIndexes[pageIndex] >= userStoryList.length - 1) {
                parentPageController.nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.ease);
              } else {
                pageControllers[pageIndex].nextPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.ease);
              }
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
              margin: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width / 2),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (currentIndexes[pageIndex] <= 0) {
                parentPageController.previousPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.ease);
              } else {
                pageControllers[pageIndex].previousPage(
                    duration: Duration(milliseconds: 100),
                    curve: Curves.ease);
              }
            },
            child: Container(
              color: Colors.transparent,
              width: MediaQuery.of(context).size.width / 2,
              height: MediaQuery.of(context).size.height,
            ),
          ),
          Positioned(
            top: 30,
            left: 15,
            child: Material(
                color: Colors.transparent,
                child: Container(
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ClipOval(
                          child: Image.network(
                              storyData.storyList[pageIndex].profileUrl!,
                              fit: BoxFit.fitHeight)),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "${storyData.storyList[pageIndex].username!}",
                        style: TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                )),
          ),
        ],
      ),
    );
  }
}