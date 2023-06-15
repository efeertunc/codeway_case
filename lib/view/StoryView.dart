import 'package:codeway_case/view/cubit/StoriesViewModel.dart';
import 'package:codeway_case/view/cubit/StoryViewModel.dart';
import 'package:codeway_case/view/repo/StoryRepository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FullScreenImage extends StatefulWidget {
  int profileIndex = 0;

  FullScreenImage(int index){
    this.profileIndex = index;
  }

  @override
  _FullScreenImageState createState() => _FullScreenImageState();
}

class _FullScreenImageState extends State<FullScreenImage> {

  @override
  void initState() {
    context.read<StoryViewModel>().getStories();
    super.initState();
  }

  final PageController pageController = PageController();
  int currentIndex = 0;
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<StoryViewModel, StoryData> (
        builder: (context, storyData) {
          if(storyData.connectionState == ConnectionState.done){
            if(storyData.storyList.isNotEmpty){

              List<String>? userStoryList = storyData.storyList[widget.profileIndex].stories;

              return Dismissible(
                direction: DismissDirection.down,
                onDismissed: (direction) {
                  Navigator.of(context).pop();
                },
                key: Key('key'),
                child: Stack(
                  children: <Widget>[
                    PageView.builder(
                      controller: pageController,
                      itemCount: userStoryList!.length,
                      pageSnapping: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        return Image.network( userStoryList[index], fit: BoxFit.fitWidth);
                      },

                      onPageChanged: (index) {
                        setState(() {
                          currentIndex = index;
                          progress = 0;
                        });
                      },
                    ),
                    Positioned(
                      top: 10,
                      left: 0,
                      right: 0,
                      child: Row(
                        children: userStoryList.map((url) {
                          int index = userStoryList.indexOf(url);
                          return Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(3.0),
                                child: LinearProgressIndicator(
                                  value: index == currentIndex ? progress : index < currentIndex ? 1 : 0,
                                  valueColor: AlwaysStoppedAnimation<Color>(index == currentIndex ? Colors.white : Colors.white24),
                                  backgroundColor: Colors.white24,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (currentIndex > 0) {
                          pageController.animateToPage(currentIndex - 1,
                              duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        if (currentIndex < userStoryList.length - 1) {
                          pageController.animateToPage(currentIndex + 1,
                              duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                        }
                      },
                      child: Container(
                        color: Colors.transparent,
                        width: MediaQuery.of(context).size.width / 2,
                        height: MediaQuery.of(context).size.height,
                        margin: EdgeInsets.only(left: MediaQuery.of(context).size.width / 2),
                      ),
                    ),
                    Positioned(
                      top: 25,
                      right: 10,
                      child: Material(
                        color: Colors.transparent,
                        child: IconButton(
                          icon: Icon(Icons.close, color: Colors.white),
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      ),
                    ),
                    Positioned(
                      top: 30,
                      left: 15,
                      child: Material(
                          color: Colors.transparent,
                          child: Container(
                            width: 100,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ClipOval(child: Image.network(userStoryList[0], fit: BoxFit.cover)),
                                Text("efertunc", style: TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold), )
                              ],
                            ),
                          )
                      ),
                    ),
                  ],
                ),
              );
            }
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }

}
