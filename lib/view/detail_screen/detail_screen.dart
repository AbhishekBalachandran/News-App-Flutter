import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:news_app/utils/color_constants/color_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailScreen extends StatelessWidget {
  final endpoint;
  const DetailScreen({super.key, required this.endpoint});

  @override
  Widget build(BuildContext context) {
    _launchUrl(url) async {
      if (!await launchUrl(Uri.parse(url))) {
        const snackbar = SnackBar(
          content: Text('Could not launch url'),
        );
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }

    return Scaffold(
      backgroundColor: ColorConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: ColorConstants.backgroundColor,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.arrow_back,
            color: ColorConstants.primaryTxtColor,
          ),
        ),
        leadingWidth: 10,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
          child: SizedBox(
            width: double.infinity,
            child: Center(
              child: Text(
                endpoint.title ?? '',
                style: TextStyle(
                    color: ColorConstants.primaryTxtColor,
                    fontSize: 22,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Published on ${endpoint.publishedAt.hour}:${endpoint.publishedAt.minute}, ${endpoint.publishedAt.day}-${endpoint.publishedAt.month}-${endpoint.publishedAt.year}',
                style: TextStyle(color: ColorConstants.containerBg),
              ),
            ),
          ],
        ),
        ListTile(
            title: Text(
              endpoint.source.name ?? '',
              style: TextStyle(
                  color: ColorConstants.primaryTxtColor,
                  fontSize: 20,
                  fontWeight: FontWeight.w500),
            ),
            trailing: IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) => Container(
                    width: double.infinity,
                    color: ColorConstants.backgroundColor,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: ListTile(
                            leading: Icon(
                              Icons.share_outlined,
                              color: ColorConstants.primaryTxtColor,
                            ),
                            title: Text(
                              'Share',
                              style: TextStyle(
                                  color: ColorConstants.primaryTxtColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: ListTile(
                            leading: Icon(
                              Icons.visibility_off_outlined,
                              color: ColorConstants.primaryTxtColor,
                            ),
                            title: Text(
                              'Show less of such content',
                              style: TextStyle(
                                  color: ColorConstants.primaryTxtColor),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 4),
                          child: ListTile(
                            leading: Icon(
                              Icons.flag_outlined,
                              color: ColorConstants.primaryTxtColor,
                            ),
                            title: Text(
                              'Reports',
                              style: TextStyle(
                                  color: ColorConstants.primaryTxtColor),
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
            )),
        endpoint.urlToImage != null
            ? Container(
                height: 300,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(endpoint.urlToImage ?? ''),
                      fit: BoxFit.fill),
                ),
              )
            : Padding(
              padding: const EdgeInsets.all(8.0),
              child: DottedBorder(
                  borderType: BorderType.RRect,
                  dashPattern: [8, 4],
                  strokeWidth: 1,
                  color: ColorConstants.secondaryTxtColor,
                  radius: Radius.circular(12),
                  padding: EdgeInsets.all(6),
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      child: Center(
                        child: Icon(
                          Icons.image_not_supported_outlined,
                          size: 30,
                          color: ColorConstants.secondaryTxtColor,
                        ),
                      ),
                    ),
                  ),
                ),
            ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              endpoint.description ?? '',
              style: TextStyle(
                  color: ColorConstants.secondaryTxtColor, fontSize: 18),
            ),
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              endpoint.content ?? '',
              style: TextStyle(
                  color: ColorConstants.primaryTxtColor, fontSize: 18),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextButton(
                onPressed: () {
                  _launchUrl(endpoint.url);
                },
                child: Text(
                  'See more',
                  style: TextStyle(color: Colors.blue),
                )),
          ],
        )
      ]),
    );
  }
}
