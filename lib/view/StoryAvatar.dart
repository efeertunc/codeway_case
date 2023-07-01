import 'package:codeway_case/view/MainView.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../cubit/StoryViewModel.dart';
import '../repo/StoryRepository.dart';

class StoryAvatar extends StatefulWidget {
  StoryAvatar();

  @override
  _StoryAvatarState createState() => _StoryAvatarState();
}

class _StoryAvatarState extends State<StoryAvatar> {
  @override
  void initState() {
    context.read<StoryViewModel>().getStories();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryViewModel, StoryData>(
        builder: (context, storyData) {
      if (storyData.connectionState == ConnectionState.done) {
        if (storyData.storyList.isNotEmpty) {
          return Column(
            children: [
              Container(
                height: 48.sp,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: storyData.storyList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => MainView(index),
                            fullscreenDialog: true,
                          ),
                        );
                      },
                      child: Padding(
                          padding: EdgeInsets.all(13.sp),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: Container(
                                      width: 37.0.sp,
                                      height: 37.0.sp,
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
                                      padding: EdgeInsets.all(7.5.sp),
                                      child: ClipOval(
                                        child: Image.network(
                                          storyData
                                              .storyList[index].profileUrl!,
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                      "${storyData.storyList[index].username!}")
                                ],
                              ),
                            ],
                          )),
                    );
                  },
                ),
              ),
            ],
          );
        }
      }
      return CircularProgressIndicator();
    });
  }
}
