import 'package:flutter/material.dart';
import 'package:ira_app/screens/login_screen/component/body.dart';
import 'package:ira_app/size_config.dart';

class LoginScreen extends StatelessWidget {
  static String routeName = '/loginScreen';
  @override
  Widget build(BuildContext context) {
    //You have to call it on your starting screen
    SizeConfig().init(context);
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      body: Body(),
    );
  }
}
