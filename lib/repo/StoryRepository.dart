import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:codeway_case/model/Story.dart';
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
}

class StoryData {
  final ConnectionState connectionState;
  final List<Story> storyList;

  StoryData(
    this.connectionState,
    this.storyList,
  );
}
