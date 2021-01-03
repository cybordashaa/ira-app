import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_html/style.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/podo/news.dart';
import 'package:timeago/timeago.dart' as timeago;

class DetailScreen extends StatelessWidget {
  final NewsList newsLists;
  DetailScreen({Key key, @required this.newsLists}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
                backgroundColor: kPrimaryColor,
                expandedHeight: 300.0,
                floating: false,
                pinned: true,
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    colors: [
                      Color(0xFF008197),
                      Color(0XFF12dae0),
                    ],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  )),
                  child: FlexibleSpaceBar(
                    title: Text(
                      'Peter',
                      style: TextStyle(fontSize: 15),
                    ),
                    background: Stack(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: double.infinity,
                          child: CachedNetworkImage(
                            imageUrl:
                                "http://192.168.1.4:8001/images/news/${newsLists.image}",
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
                              width: 350,
                              child: Center(
                                child: CircularProgressIndicator(
                                  backgroundColor: kPrimaryColor,
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => Image.asset(
                              "assets/images/place.png",
                              fit: BoxFit.cover,
                              height: 125,
                              width: 350,
                            ),
                            height: 125,
                            width: 350,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.8)
                            ],
                            begin: Alignment.topCenter,
                            stops: [0.6, 1],
                            end: Alignment.bottomCenter,
                          )),
                          padding: EdgeInsets.only(top: 30, bottom: 10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontFamily: 'Sigmar'),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      height: 45,
                                      decoration:
                                          BoxDecoration(shape: BoxShape.circle),
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(100),
                                        child: Image.asset(
                                          "assets/images/cardimage.jpg",
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      timeago.format(newsLists.createdAt),
                                      style: TextStyle(color: Colors.white),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ))
          ];
        },
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: 300,
          padding: EdgeInsets.all(20),
          child: ListView(
            children: [
              Text(
                "${newsLists.title.replaceAll(r"\", "")}",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   newsLists.text,
              //   style: TextStyle(
              //     fontSize: 18,
              //   ),
              // ),
              Html(
                data: "${newsLists.text}",
                style: {
                  "html": Style(
                      // backgroundColor: Theme.of(context).backgroundColor,
                      fontSize: FontSize.large,
                      fontFamily: 'Raleway-italic',
                      color: Color(0xFF242424))
                },
                onLinkTap: (url) {},
                onImageTap: (src) {},
              ),
              SizedBox(
                height: 20,
              ),
              // Text(
              //   "Share this Post:",
              //   style: TextStyle(
              //     fontWeight: FontWeight.w700,
              //     fontSize: 24,
              //   ),
              // ),
              // SizedBox(
              //   height: 10,
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         margin: EdgeInsets.only(right: 5),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Color(0xff4267B2),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             SvgPicture.asset(
              //               "assets/icons/picture.svg",
              //               height: 18,
              //               color: Colors.white,
              //             ),
              //             Text(
              //               "Facebook",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 15,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         margin: EdgeInsets.only(right: 5),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           color: Colors.blue,
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             SvgPicture.asset(
              //               "assets/icons/picture.svg",
              //               height: 18,
              //               color: Colors.white,
              //             ),
              //             Text(
              //               "Twitter",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 15,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     ),
              //     Expanded(
              //       child: Container(
              //         padding: EdgeInsets.all(10),
              //         decoration: BoxDecoration(
              //           borderRadius: BorderRadius.circular(20),
              //           gradient: LinearGradient(
              //             colors: [
              //               Color(0xffFD1D1D),
              //               Color(0xffC13584),
              //             ],
              //             begin: Alignment.topLeft,
              //             end: Alignment.bottomRight,
              //           ),
              //         ),
              //         child: Row(
              //           mainAxisAlignment: MainAxisAlignment.spaceAround,
              //           crossAxisAlignment: CrossAxisAlignment.end,
              //           children: [
              //             SvgPicture.asset(
              //               "assets/icons/picture.svg",
              //               height: 18,
              //               color: Colors.white,
              //             ),
              //             Text(
              //               "Instagram",
              //               style: TextStyle(
              //                 color: Colors.white,
              //                 fontSize: 15,
              //               ),
              //             ),
              //           ],
              //         ),
              //       ),
              //     )
              //   ],
              // ),
              // SizedBox(
              //   height: 20,
              // ),
              // Text(
              //   "Share this Post:",
              //   style: TextStyle(
              //     fontWeight: FontWeight.w700,
              //     fontSize: 24,
              //   ),
              // ),
              // SizedBox(
              //   height: 20,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
