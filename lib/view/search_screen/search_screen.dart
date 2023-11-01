import 'package:flutter/material.dart';
import 'package:news_app/controller/search_screen_controller.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:news_app/view/detail_screen/detail_screen.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController search_controller = TextEditingController();

  @override
  void initState() {
    Provider.of<SearchScreenController>(context, listen: false)
        .fetchNewsSearchScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: ColorConstants.backgroundColor,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: ColorConstants.backgroundColor,
                expandedHeight: 100,
                automaticallyImplyLeading: false,
                flexibleSpace: FlexibleSpaceBar(
                  background: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              color: ColorConstants.txtFieldBackgroundColor),
                          child: Center(
                            child: TextField(
                              style: TextStyle(
                                  color: ColorConstants.primaryTxtColor),
                              controller: search_controller,
                              onChanged: (value) =>
                                  Provider.of<SearchScreenController>(context,
                                          listen: false)
                                      .fetchNewsSearchScreen(
                                          searchKeyword:
                                              search_controller.text),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(
                                    Icons.search,
                                    color: ColorConstants.primaryTxtColor,
                                  ),
                                  border: InputBorder.none,
                                  hintText: 'Search News',
                                  hintStyle: TextStyle(
                                      color: ColorConstants.primaryTxtColor,
                                      fontSize: 18)),
                            ),
                          ),
                        ),
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.start,
                      //   children: [
                      //     Padding(
                      //       padding: const EdgeInsets.symmetric(
                      //           horizontal: 16, vertical: 4),
                      //       child: Text(
                      //         'Popular Searches',
                      //         style: TextStyle(
                      //             color: ColorConstants.primaryTxtColor,
                      //             fontSize: 18,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ],
                      // ),
                    ],
                  ),
                ),
              ),
              Provider.of<SearchScreenController>(context).isLoading == true
                  ? SliverToBoxAdapter(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                          ),
                          CircularProgressIndicator(),
                        ],
                      ),
                    )
                  : context.watch<SearchScreenController>().news_model == null
                      ? SliverToBoxAdapter(
                        child: Center(
                            child: Text(
                              'Nothing to show',
                              style: TextStyle(
                                  color: ColorConstants.primaryTxtColor),
                            ),
                          ),
                      )
                      : SliverGrid.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemCount: context
                              .read<SearchScreenController>()
                              .news_model
                              ?.articles
                              ?.length,
                          itemBuilder: (context, index) => Padding(
                            padding: const EdgeInsets.all(5),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DetailScreen(
                                          endpoint: Provider.of<SearchScreenController>(context).news_model?.articles?[index]),
                                    ));
                              },
                              child: Container(
                                height: 100,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: NetworkImage(context
                                              .read<SearchScreenController>()
                                              .news_model
                                              ?.articles?[index]
                                              .urlToImage ??
                                          ''),
                                      fit: BoxFit.cover,
                                      opacity: 0.6),
                                  color: Color.fromARGB(255, 1, 55, 23)
                                      .withOpacity(1.0),
                                  backgroundBlendMode: BlendMode.softLight,
                                ),
                                child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      SizedBox(
                                        width: double.infinity,
                                        height: 50,
                                        child: Padding(
                                          padding: const EdgeInsets.all(5),
                                          child: Text(
                                            context
                                                    .read<
                                                        SearchScreenController>()
                                                    .news_model
                                                    ?.articles?[index]
                                                    .title ??
                                                '',
                                            style: TextStyle(
                                                color: ColorConstants
                                                    .primaryTxtColor),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      )
                                    ]),
                              ),
                            ),
                          ),
                        )
            ],
          ),
        ));
  }
}
