import 'package:flutter/material.dart';
import 'package:ira_app/screens/login_screen/component/body.dart';
import 'package:ira_app/size_config.dart';

class LoginScreen extends StatefulWidget {
  static String routeName = '/loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    //You have to call it on your starting screen
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(),
      body: Body(),
    );
  }
}
