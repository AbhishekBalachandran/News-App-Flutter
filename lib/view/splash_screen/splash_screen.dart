import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:news_app/view/bottom_navigation/bottom_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3)).then((value) => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomNavigation(),
        )));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                  color: ColorConstants.bannerColor,
                  width: 2,
                  style: BorderStyle.solid),
            ),
          ),
          child: Text(
            'News India.',
            style: GoogleFonts.bebasNeue(
                color: ColorConstants.primaryTxtColor, fontSize: 40),
          ),
        ),
      ),
    );
  }
}
