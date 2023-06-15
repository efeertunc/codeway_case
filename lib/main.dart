import 'package:codeway_case/view/StoryAvatar.dart';
import 'package:codeway_case/view/cubit/StoriesViewModel.dart';
import 'package:codeway_case/view/cubit/StoryViewModel.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(create: (context) => StoryViewModel()),
      BlocProvider(create: (context) => StoriesViewModel()),
    ],
    child: const MyApp(),
  ),);
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
  MyHomePage({super.key});

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
            Container(child: StoryAvatar()),
            Spacer(),
            Text("deneme"),
            Spacer(),
          ]),
        ));
  }
}
