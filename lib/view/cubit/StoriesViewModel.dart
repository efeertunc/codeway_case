import 'package:codeway_case/view/repo/StoryRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class StoriesViewModel extends Cubit<StoriesData> {
  StoriesViewModel() : super(StoriesData(ConnectionState.waiting, []));

  var repo = StoryRepository();

  Future<void> getAllStories() async {
    var storyData = await repo.getAllStories();
    emit(storyData);
  }
}
