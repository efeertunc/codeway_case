import 'package:codeway_case/view/AnimatedBar.dart';
import 'package:codeway_case/view/StoryContentPage.dart';
import 'package:codeway_case/view/VideoPlayProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/StoryViewModel.dart';
import '../model/Story.dart';
import '../repo/StoryRepository.dart';

class StoryView extends StatefulWidget {
  int? profileIndex;

  StoryView(int profileIndex) {
    this.profileIndex = profileIndex;
  }

  @override
  _StoryView createState() => _StoryView();
}

class _StoryView extends State<StoryView> with TickerProviderStateMixin {
  List<PageController> pageControllers = [];
  List<int> currentIndexes = [];
  List<AnimationController> animationControllers = [];
  late PageController parentPageController;

  @override
  void initState() {
    super.initState();
    parentPageController =
        PageController(initialPage: widget.profileIndex ?? 0);

    context.read<StoryViewModel>().getStories().then((storyData) {
      if (storyData.connectionState == ConnectionState.done) {
        if (storyData.storyList.isNotEmpty) {
          storyData.storyList.forEach((story) {
            story.stories?.forEach((element) {
              if (element.toLowerCase().endsWith('.mp4')) {
                ;
                AnimationController animationController = AnimationController(
                  vsync: this,
                  duration: const Duration(seconds: 25),
                )..forward();
                animationControllers.add(animationController);
              } else {
                AnimationController animationController = AnimationController(
                  vsync: this,
                  duration: const Duration(seconds: 5),
                )..forward();
                animationControllers.add(animationController);
              }
            });

            pageControllers.add(PageController());
            currentIndexes.add(0);
          });

          setState(() {});
        }
      }
    });
  }

  @override
  void dispose() {
    animationControllers.forEach((controller) {
      controller.stop();
      controller.dispose();
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<StoryViewModel, StoryData>(
        builder: (context, storyData) {
          if (storyData.connectionState == ConnectionState.done) {
            if (storyData.storyList.isNotEmpty) {
              if (animationControllers.isEmpty) {
                return Center(child: CircularProgressIndicator());
              }

              return Dismissible(
                  direction: DismissDirection.down,
                  onDismissed: (direction) {
                    Navigator.of(context).pop();
                    context.read<VideoPlayerProvider>().playPause(false);
                  },
                  key: Key('key'),
                  child: buildPageView(storyData));
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildPageView(StoryData storyData) {
    var pageChildren = storyData.storyList.asMap().entries.map((entry) {
      int pageIndex = entry.key;
      Story currentStory = entry.value;

      pageControllers.add(PageController());
      currentIndexes.add(0);

      return buildStoryPage(currentStory.stories!, pageIndex, storyData);
    }).toList();

    return PageView(
      controller: parentPageController,
      scrollDirection: Axis.horizontal,
      allowImplicitScrolling: true,
      children: pageChildren,
      onPageChanged: (index) {
        setState(() {
          context.read<VideoPlayerProvider>().playPause(false);
          animationControllers[index].reset();
          animationControllers[index].forward();
        });
      },
    );
  }

  Widget buildStoryPage(
      List<String> userStoryList, int pageIndex, StoryData storyData) {
    return GestureDetector(
      onLongPressStart: (_) => handleLongPressStart(userStoryList, pageIndex),
      onLongPressEnd: (_) => handleLongPressEnd(userStoryList, pageIndex),
      child: buildStoryContent(
          userStoryList, pageIndex, storyData, animationControllers[pageIndex]),
    );
  }

  void handleAnimationEnd(List<String> userStoryList, int pageIndex) {
    if (pageControllers[pageIndex].hasClients) {
      if (currentIndexes[pageIndex] >= userStoryList.length - 1) {
        parentPageController.nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      } else {
        pageControllers[pageIndex].nextPage(
          duration: Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    }
  }

  void handleLongPressStart(List<String> userStoryList, int pageIndex) {
    if (isVideo(userStoryList, pageIndex)) {
      context.read<VideoPlayerProvider>().playPause(false);
    }
    animationControllers[pageIndex].stop();
  }

  void handleLongPressEnd(List<String> userStoryList, int pageIndex) {
    if (isVideo(userStoryList, pageIndex)) {
      context.read<VideoPlayerProvider>().playPause(true);
    }
    animationControllers[pageIndex].forward();
  }

  bool isVideo(List<String> userStoryList, int pageIndex) {
    return userStoryList[currentIndexes[pageIndex]]
        .toLowerCase()
        .endsWith('.mp4');
  }

  Widget buildStoryContent(List<String> userStoryList, int pageIndex,
      StoryData storyData, AnimationController animationController) {
    return Stack(
      children: [
        buildPageViewBuilder(
            userStoryList, pageIndex, storyData, animationController),
        buildUserInteractionArea(userStoryList, pageIndex),
        buildUserDetailArea(storyData, pageIndex),
      ],
    );
  }

  Widget buildPageViewBuilder(List<String> userStoryList, int pageIndex,
      StoryData storyData, AnimationController animationController) {
    return PageView.builder(
      controller: pageControllers[pageIndex],
      itemCount: userStoryList.length,
      pageSnapping: false,
      allowImplicitScrolling: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Stack(
          children: [
            StoryContentPage(
              contentPath: userStoryList[currentIndexes[pageIndex]],
            ),
            buildAnimatedBar(
                userStoryList.length, currentIndexes[pageIndex], pageIndex),
          ],
        );
      },
      onPageChanged: (index) {
        setState(() {
          context.read<VideoPlayerProvider>().playPause(false);
          currentIndexes[pageIndex] = index;
          animationControllers[pageIndex].reset();
          animationControllers[pageIndex].forward();
        });
      },
    );
  }

  Widget buildUserInteractionArea(List<String> userStoryList, int pageIndex) {
    return Row(
      children: [
        buildPreviousTapArea(pageIndex),
        buildNextTapArea(userStoryList, pageIndex),
      ],
    );
  }

  Widget buildNextTapArea(List<String> userStoryList, int pageIndex) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (currentIndexes[pageIndex] >= userStoryList.length - 1) {
            parentPageController.nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          } else {
            pageControllers[pageIndex].nextPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        },
      ),
    );
  }

  Widget buildPreviousTapArea(int pageIndex) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if (currentIndexes[pageIndex] <= 0) {
            parentPageController.previousPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          } else {
            pageControllers[pageIndex].previousPage(
              duration: Duration(milliseconds: 500),
              curve: Curves.ease,
            );
          }
        },
      ),
    );
  }

  Widget buildUserDetailArea(StoryData storyData, int pageIndex) {
    return Positioned(
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
                  fit: BoxFit.fitHeight,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                "${storyData.storyList[pageIndex].username!}",
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildAnimatedBar(int length, int currentIndex, int pageIndex) {
    return Row(
      children: List.generate(
        length,
        (index) => AnimatedBar(
          animationController: animationControllers[pageIndex],
          position: index,
          currentIndex: currentIndex,
        ),
      ),
    );
  }
}
