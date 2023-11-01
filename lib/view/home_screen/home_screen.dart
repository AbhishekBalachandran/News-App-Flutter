import 'package:flutter/material.dart';
import 'package:news_app/controller/home_screen_controller.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:news_app/view/home_screen/widgets/page_container.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    Provider.of<HomeScreenController>(context, listen: false)
        .fetchNewsHomeScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      body: Provider.of<HomeScreenController>(context).isLoading == true
          ? Center(
              child: CircularProgressIndicator(
              color: ColorConstants.bannerColor,
            ))
          : Provider.of<HomeScreenController>(context,listen: false).news_model == null
              ? Center(
                  child: Text(
                    'Nothing to show',
                    style: TextStyle(color: ColorConstants.primaryTxtColor),
                  ),
                )
              : RefreshIndicator(
                  onRefresh: () async {
                    await Provider.of<HomeScreenController>(context,
                            listen: false)
                        .fetchNewsHomeScreen();
                  },
                  child: PageView.builder(
                    scrollDirection: Axis.vertical,
                    scrollBehavior: MaterialScrollBehavior(),
                    itemCount: Provider.of<HomeScreenController>(context)
                        .news_model
                        ?.articles
                        ?.length,
                    itemBuilder: (context, index) =>
                        PageContainer(itemIndex: index),
                  ),
                ),
    );
  }
}
