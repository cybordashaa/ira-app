import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/screens/news_screen/news_book_card.dart';
import 'package:provider/provider.dart';
import 'package:ira_app/provider/home_provider.dart';
import 'package:ira_app/podo/news.dart';

class NewsScreen extends StatefulWidget {
  _NewsScreenState createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  ScrollController _scrollController;
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _scrollController = ScrollController();
    final fetchNews = Provider.of<HomeProvider>(context, listen: false);
    Future.microtask(() => fetchNews.getFetchNewsList());
  }

  void changePage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(builder: (context, homeProvider, child) {
      // print(homeProvider.news.newsLists.length);
      return homeProvider.loading
          ? Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
              ),
            )
          : RefreshIndicator(
              onRefresh: () => homeProvider.getFetchNewsList(),
              child: homeProvider.newsCount == 0
                  ? ListView.builder(
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: Text('no medee'),
                        );
                      })
                  : Container(
                      child: ListView.builder(
                      itemCount: homeProvider.newsCount,
                      itemBuilder: (context, index) {
                        NewsList newsLists = homeProvider.news.newsLists[index];
                        return Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 15, vertical: 10),
                          child: NewsBookCard(
                              newsLists: newsLists, img: newsLists.image),
                        );
                      },
                      padding: EdgeInsets.symmetric(horizontal: 15),
                    )),
              // child: NestedScrollView(
              //     controller: _scrollController,
              //     headerSliverBuilder: (context, value) {
              //       return [
              //         SliverToBoxAdapter(
              //           child: Padding(
              //             padding: const EdgeInsets.fromLTRB(25, 10, 25, 25),
              //             child: Align(
              //               alignment: Alignment.centerLeft,
              //               child: Text(
              //                 "Мэдээ мэдээлэл",
              //                 textAlign: TextAlign.left,
              //                 style: TextStyle(
              //                   fontFamily: "Times",
              //                   fontSize: 34,
              //                   fontWeight: FontWeight.w700,
              //                 ),
              //               ),
              //             ),
              //           ),
              //         ),
              //       ];
              //     },
              //     body: Container(
              //         child: ListView.builder(
              //       itemCount: 10,
              //       itemBuilder: (context, index) => Padding(
              //         padding:
              //             EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              //         child: NewsBookCard(
              //             img:
              //                 "https://newsbeat.kiwi/wp-content/uploads/2018/09/newsa-768x432.jpg"),
              //       ),
              //       padding: EdgeInsets.symmetric(horizontal: 15),
              //     ))
              //     ),
            );
    });
  }
}
