import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/podo/news.dart';
import 'package:ira_app/screens/news_screen/news_detail.dart';
import 'package:page_transition/page_transition.dart';

class NewsBookCard extends StatelessWidget {
  final String img;
  final NewsList newsLists;

  NewsBookCard({Key key, @required this.img, @required this.newsLists})
      : super(key: key);
  String formatDateTime(DateTime dateTime) {
    return '${dateTime.day}/${dateTime.month}/${dateTime.year}';
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(10)),
        boxShadow: [
          BoxShadow(
              color: Theme.of(context).focusColor.withOpacity(0.05),
              blurRadius: 2,
              offset: Offset(0, 3))
        ],
      ),
      child: InkWell(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10)),
        onTap: () {
          Navigator.push(
              context,
              PageTransition(
                  child: DetailScreen(newsLists: newsLists),
                  type: PageTransitionType.rightToLeft));
        },
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Hero(
                    tag: '${newsLists.id}',
                    // child: Image(
                    //   image: AssetImage('assets/images/cardimage.jpg'),
                    //   fit: BoxFit.cover,
                    //   height: 125,
                    //   width: 350,
                    // )
                    child: CachedNetworkImage(
                      imageUrl: "http://192.168.1.4:8001/images/news/$img",
                      imageBuilder: (context, imageProvider) => Container(
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      placeholder: (context, url) => Container(
                        height: 125,
                        width: MediaQuery.of(context).size.width,
                        child: Center(
                          child: CircularProgressIndicator(
                            valueColor: new AlwaysStoppedAnimation<Color>(
                                kPrimaryColor),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        "assets/images/place.png",
                        fit: BoxFit.cover,
                        height: 125,
                        width: MediaQuery.of(context).size.width,
                      ),
                      height: 125,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Positioned(
                //   right: 10.0,
                //   bottom: 10.0,
                //   child: Container(
                //     padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(5),
                //         color: kPrimaryColor),
                //     child: Text("here is category",
                //         style:
                //             TextStyle(fontSize: 12, color: kPrimaryLightColor)),
                //   ),
                // )
              ],
            ),
            SizedBox(
              height: 5,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              alignment: Alignment.centerLeft,
              child: Text(
                newsLists.title,
                style: TextStyle(fontWeight: FontWeight.w800),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              alignment: Alignment.centerLeft,
              child: Row(
                children: [
                  Container(
                    child: Icon(
                      Icons.date_range,
                      color: kPrimaryColor,
                      size: 12.0,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "${formatDateTime(newsLists.createdAt)}",
                      style: TextStyle(fontSize: 12),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: Icon(
                      Icons.visibility,
                      color: Theme.of(context).accentColor,
                      size: 12,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "12",
                      style: TextStyle(fontSize: 12),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
