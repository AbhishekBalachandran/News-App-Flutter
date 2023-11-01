import 'package:flutter/material.dart';
import 'package:news_app/controller/all-news_screen_controlller.dart';
import 'package:news_app/controller/home_screen_controller.dart';
import 'package:news_app/controller/search_screen_controller.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:news_app/view/splash_screen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}   

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
     providers: [
      ChangeNotifierProvider(create: (context) => HomeScreenController(),),
      ChangeNotifierProvider(create: (context) => SearchScreenController(),),
      ChangeNotifierProvider(create: (context) => AllNewsController(),)
     ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News India',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorConstants.bannerColor),
          useMaterial3: true,
        ),
        home: SplashScreen(),
      ),
    );
  }
}
