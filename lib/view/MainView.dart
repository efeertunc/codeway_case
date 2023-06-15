import 'package:codeway_case/view/Deneme.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'VideoPlayProvider.dart';

class MainView extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => VideoPlayerProvider(),
      child: Deneme(0),
    );
  }
}
