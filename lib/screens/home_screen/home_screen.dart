import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/core/get_it.dart';
import 'package:ira_app/helper/socket_helper.dart';
import 'package:ira_app/screens/chat/chat.dart';
import 'package:ira_app/screens/chat_screen/chat_screen.dart';
import 'package:ira_app/screens/dashboard_screen/dashboard_screen.dart';
import 'package:ira_app/screens/login_screen/login_screen.dart';
import 'package:ira_app/screens/news_screen/news_screen.dart';
import 'package:ira_app/screens/notificaton_screen/notification_screen.dart';
import 'package:ira_app/screens/profile_screen/profile_screen.dart';
import 'package:ira_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

import 'package:ira_app/viewModel/chat_view_model_list.dart';

class HomeScreen extends StatefulWidget {
  static String routeName = '/home_screen';
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  TabController controller;
  // var userData;
  String token;
  @override
  void initState() {
    SocketHelper.shared.connectSocket();
    _getUserInfo();
    controller = new TabController(
      vsync: this,
      length: 5,
    );
    // tabedBar listeneer
    controller.addListener(_handleTabSelection);
    // TODO: implement initState
    super.initState();
  }

  // get token use info check
  void _getUserInfo() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    // var userJson = localStorage.getString('user');
    var token = localStorage.getString('token');
    // var user = json.decode(userJson);
    setState(() {
      // userData = user;
      token = token;
    });
  }

  void _handleTabSelection() {
    setState(() {});
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  /// socket

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Color(0xFFF5F6F9),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(70.0),
        child: new AppBar(
          elevation: 1.0,
          bottom: new TabBar(
            controller: controller,
            indicatorColor: kPrimaryColor,
            tabs: [
              Container(
                child: new Tab(
                    icon: SvgPicture.asset(
                  'assets/icons/home.svg',
                  height: getProportionateScreenHeight(30),
                  color: controller.index == 0 ? kPrimaryColor : Colors.black87,
                )),
              ),
              Container(
                child: new Tab(
                    icon: SvgPicture.asset('assets/icons/flag.svg',
                        height: getProportionateScreenHeight(30),
                        color: controller.index == 1
                            ? kPrimaryColor
                            : Colors.black87)),
              ),
              Container(),
              Container(
                child: new Tab(
                    icon: SvgPicture.asset('assets/icons/bell.svg',
                        height: getProportionateScreenHeight(30),
                        color: controller.index == 3
                            ? kPrimaryColor
                            : Colors.black87)),
              ),
              Container(
                child: new Tab(
                    icon: SvgPicture.asset('assets/icons/user.svg',
                        height: getProportionateScreenHeight(30),
                        color: controller.index == 4
                            ? kPrimaryColor
                            : Colors.black87)),
              )
            ],
          ),
        ),
      ),
      body: new TabBarView(
        controller: controller,
        physics: NeverScrollableScrollPhysics(),
        children: [
          Padding(padding: EdgeInsets.all(5.0), child: new DashboardScreen()),
          // new NewsHomeScreen(),
          new NewsScreen(),
          new NewsScreen(),
          new NotificationScreen(),
          new ProfileScreen()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10.0,
        backgroundColor: Colors.white,
        onPressed: () async {
          // Navigator.pushNamed(context, ChatScreen.routeName)
          // logout()
          // Navigator.of(context).push(new MaterialPageRoute(builder: (BuildContext context) => new ChatScreen(token: token )))
          SocketHelper.shared.joinRoom(ops: false);
          getIt<ChatListState>().messageList.clear();
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => ChatView()));
        },
        child: SvgPicture.asset(
          'assets/icons/logo.svg',
          height: getProportionateScreenHeight(30),
          color: kPrimaryColor,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
    );
  }
}
