import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/controller/all-news_screen_controlller.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:news_app/utils/databases/database.dart';
import 'package:news_app/view/detail_screen/detail_screen.dart';
import 'package:provider/provider.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  @override
  void initState() {
    Provider.of<AllNewsController>(context, listen: false).fetchAllNews();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AllNewsController>(context);
    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      drawer: Drawer(
        backgroundColor: ColorConstants.backgroundColor,
        child: ListView(children: [
          DrawerHeader(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: ColorConstants.containerBg,
                        radius: 30,
                        child: Center(
                            child: Icon(
                          Icons.person_outline,
                          color: ColorConstants.primaryTxtColor,
                        )),
                      ),
                      title: Text(
                        'Welcome User',
                        style: TextStyle(
                            color: ColorConstants.primaryTxtColor,
                            fontSize: 18),
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.close,
                          color: ColorConstants.primaryTxtColor,
                        ),
                      )),
                )
              ],
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.download_outlined,
              color: ColorConstants.primaryTxtColor,
            ),
            title: Text(
              'Saved Content',
              style: TextStyle(color: ColorConstants.primaryTxtColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.bookmark_outline,
              color: ColorConstants.primaryTxtColor,
            ),
            title: Text(
              'Bookmarks',
              style: TextStyle(color: ColorConstants.primaryTxtColor),
            ),
          ),
          ListTile(
            leading: Icon(
              Icons.notifications_outlined,
              color: ColorConstants.primaryTxtColor,
            ),
            title: Text(
              'Notifications',
              style: TextStyle(color: ColorConstants.primaryTxtColor),
            ),
          )
        ]),
      ),
      appBar: AppBar(
        iconTheme: IconThemeData(color: ColorConstants.primaryTxtColor),
        backgroundColor: ColorConstants.backgroundColor,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
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
                  color: ColorConstants.primaryTxtColor, fontSize: 35),
            ),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: ColorConstants.primaryTxtColor,
            ),
          )
        ],
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          height: 80,
          padding: EdgeInsets.all(10),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Provider.of<AllNewsController>(context, listen: false)
                      .fetchAllNews(category: categories[index]['key']);
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 60, 90, 95),
                      border: Border.all(
                          color: ColorConstants.txtFieldBackgroundColor),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 5),
                      child: Text(
                        categories[index]['category'],
                        style: TextStyle(color: ColorConstants.primaryTxtColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        // News list
        provider.isLoading == true
            ? Center(
                child: CircularProgressIndicator(
                color: ColorConstants.bannerColor,
              ))
            : context.watch<AllNewsController>().newsModel == null
                ? Center(
                    child: Text(
                      'Nothing to show',
                      style: TextStyle(color: ColorConstants.primaryTxtColor),
                    ),
                  )
                : RefreshIndicator(
                  onRefresh: ()async{
                    await Provider.of<AllNewsController>(context,listen: false).fetchAllNews();

                  },
                  child: Expanded(
                      child: ListView.separated(
                        itemCount: context
                                .read<AllNewsController>()
                                .newsModel
                                ?.articles
                                ?.length ??
                            0,
                        itemBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailScreen(
                                        endpoint:
                                            provider.newsModel?.articles?[index]),
                                  ));
                            },
                            child: Container(
                              width: double.infinity,
                              height: 400,
                              child: Column(children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(15),
                                      image: DecorationImage(
                                          image: NetworkImage(provider.newsModel
                                                  ?.articles?[index].urlToImage ??
                                              ''),
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        provider.newsModel?.articles?[index]
                                                .source?.name ??
                                            '',
                                        style: TextStyle(
                                            color: ColorConstants.primaryTxtColor,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: Text(
                                        provider.newsModel?.articles?[index]
                                                .title ??
                                            '',
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            color: ColorConstants.primaryTxtColor,
                                            fontSize: 18)),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                          '${provider.newsModel?.articles?[index].publishedAt?.day} - ${provider.newsModel?.articles?[index].publishedAt?.month} - ${provider.newsModel?.articles?[index].publishedAt?.year}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 126, 126, 126))),
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
                                                      Icons
                                                          .share_outlined,
                                                      color: ColorConstants
                                                          .primaryTxtColor,
                                                    ),
                                                    title: Text(
                                                      'Share',
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
                                                      Icons
                                                          .visibility_off_outlined,
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
                                      ),
                                    )
                                  ],
                                )
                              ]),
                            ),
                          ),
                        ),
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          child: Divider(),
                        ),
                      ),
                    ),
                )
      ]),
    );
  }
}
