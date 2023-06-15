import 'package:codeway_case/view/repo/StoryRepository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

class StoryViewModel extends Cubit<StoryData> {
  StoryViewModel() : super(StoryData(ConnectionState.waiting, []));

  var repo = StoryRepository();

  Future<void> getStories() async {
    var storyData = await repo.getStories();
    emit(storyData);
  }

}
