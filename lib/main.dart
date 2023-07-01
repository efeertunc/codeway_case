import 'package:codeway_case/view/StoryAvatar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'cubit/StoryViewModel.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => StoryViewModel()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
        builder: (context, orientation, screenType) {
          return MaterialApp(
            home: MyHomePage(),
            debugShowCheckedModeBanner: false,
          );
        }
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
          title: Text(
            "𝘐𝘯𝘴𝘵𝘢𝘨𝘳𝘢𝘮 𝘚𝘵𝘰𝘳𝘪𝘦𝘴",
            style: TextStyle(color: Colors.black, fontSize: 18.sp),
          ),
        ),
        body: Container(
          child: SingleChildScrollView(
            child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
              Container(child: StoryAvatar()),
              Padding(
                padding: EdgeInsets.all(28.0.sp),
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0.sp),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(15.0.sp),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.all(22.0.sp),
                          child: Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10.0.sp), // half of height and width
                              ),
                              elevation: 5,
                              child: Image.network(
                                  "https://media.licdn.com/dms/image/C4E03AQGkKnwGy4kl1A/profile-displayphoto-shrink_800_800/0/1611157429759?e=1693440000&v=beta&t=nEyW9Qp4ZzSrBKF140DB6wrNyK729KwZbSKVOKBeqaQ",
                                  fit: BoxFit.cover)),
                        ),
                        SizedBox(height: 15.sp),
                        Text(
                          'Efe Ertunç',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'Koc University',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.grey[700],
                          ),
                        ),
                        SizedBox(height: 15.sp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(width: 10.sp),
                            Text(
                              'Github / Linkedin : @efeertunc',
                              style: TextStyle(
                                fontSize: 15.sp,
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}
