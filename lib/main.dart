import 'package:codeway_case/view/StoryAvatar.dart';
import 'package:codeway_case/view/StoryList.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Container(
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Container(height: 140, width: 410, child: StoryList()),
            Spacer(),
            Text("deneme"),
            Spacer(),
          ]),
        ));
  }
}
