import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeway_case/view/model/Story.dart';
import 'package:flutter/cupertino.dart';

class StoryRepository {
  final storyCollection = FirebaseFirestore.instance.collection('story');

  Future<StoryData> getStories() async {
    var snapshot = await storyCollection.get();
    return StoryData(
        ConnectionState.done,
        snapshot.docs
            .map((doc) => Story.fromJson(doc.data() as Map<String, dynamic>))
            .toList());
  }

  Future<StoriesData> getAllStories() async {
    var snapshot = await storyCollection.get();
    List<String> allStories = [];

    for (var doc in snapshot.docs) {
      Story story = Story.fromJson(doc.data() as Map<String, dynamic>);
      allStories.addAll(story.stories!);
    }

    return StoriesData(ConnectionState.done, allStories);
  }

}

class StoryData {
  final ConnectionState connectionState;
  final List<Story> storyList;

  StoryData(
    this.connectionState,
    this.storyList,
  );
}

class StoriesData {
  final ConnectionState connectionState;
  final List<String> storiesList;

  StoriesData(
      this.connectionState,
      this.storiesList,
      );
}
