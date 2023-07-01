import 'package:codeway_case/view/StoryView.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'VideoPlayProvider.dart';

class MainView extends StatelessWidget {
  int? index;

  MainView(int index) {
    this.index = index;
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoPlayerProvider(),
      child: StoryView(index ?? 0),
    );
  }
}
