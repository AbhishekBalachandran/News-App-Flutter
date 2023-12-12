import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controller/home_screen_controller.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:news_app/view/detail_screen/detail_screen.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({super.key, required this.itemIndex});
  final itemIndex;

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailScreen(
                  endpoint: Provider.of<HomeScreenController>(context)
                      .news_model
                      ?.articles?[widget.itemIndex]),
            ));
      },
      child: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
              image: NetworkImage(Provider.of<HomeScreenController>(context)
                      .news_model
                      ?.articles?[widget.itemIndex]
                      .urlToImage ??
                  ''),
              opacity: 0.5,
              fit: BoxFit.fitHeight),
          color: Color.fromARGB(255, 0, 0, 0).withOpacity(1.0),
          backgroundBlendMode: BlendMode.hardLight,
        ),
        child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
          Container(
            height: height * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 8),
                      child: Container(
                        margin: EdgeInsets.only(left: 15),
                        width: width * 0.8,
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Row(
                                children: [
                                  Container(
                                    height: 2,
                                    width: width * 0.4,
                                    decoration:
                                        BoxDecoration(color: Colors.red),
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              "${Provider.of<HomeScreenController>(context).news_model?.articles?[widget.itemIndex].title}",
                              maxLines: 5,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.oswald(
                                  color: ColorConstants.primaryTxtColor,
                                  fontSize: 20),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: width * 0.9,
                            child: Text(
                              Provider.of<HomeScreenController>(context)
                                      .news_model
                                      ?.articles?[widget.itemIndex]
                                      .description ??
                                  '',
                              style: TextStyle(
                                color: ColorConstants.primaryTxtColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 40,
                      decoration: BoxDecoration(color: Colors.black),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    Provider.of<HomeScreenController>(context)
                                            .news_model
                                            ?.articles?[widget.itemIndex]
                                            .source
                                            ?.name ??
                                        '',
                                    style: TextStyle(
                                        fontSize: 16,
                                        color: ColorConstants.primaryTxtColor),
                                  ),
                                ),
                                Icon(
                                  Icons.verified_outlined,
                                  color: ColorConstants.primaryTxtColor,
                                  size: 17,
                                )
                              ],
                            ),
                            Row(
                              children: [
                                IconButton(
                                  onPressed: () async {
                                    Share.share(
                                        "See news at ${Provider.of<HomeScreenController>(context, listen: false).news_model?.articles?[widget.itemIndex].url}");
                                  },
                                  icon: Icon(
                                    Icons.share,
                                    color: ColorConstants.primaryTxtColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: FaIcon(
                                    FontAwesomeIcons.whatsapp,
                                    color: ColorConstants.primaryTxtColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                IconButton(
                                  onPressed: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (context) => Container(
                                        width: double.infinity,
                                        color: ColorConstants.backgroundColor,
                                        child: Column(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.visibility_off_outlined,
                                                  color: ColorConstants
                                                      .primaryTxtColor,
                                                ),
                                                title: Text(
                                                  'Show less of such content',
                                                  style: TextStyle(
                                                      color: ColorConstants
                                                          .primaryTxtColor),
                                                ),
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8,
                                                      vertical: 4),
                                              child: ListTile(
                                                leading: Icon(
                                                  Icons.flag_outlined,
                                                  color: ColorConstants
                                                      .primaryTxtColor,
                                                ),
                                                title: Text(
                                                  'Reports',
                                                  style: TextStyle(
                                                      color: ColorConstants
                                                          .primaryTxtColor),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                  icon: Icon(
                                    Icons.more_vert,
                                    color: ColorConstants.primaryTxtColor,
                                    size: 20,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            )
                          ]),
                    )
                  ],
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
