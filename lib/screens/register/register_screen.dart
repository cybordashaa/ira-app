import 'package:flutter/material.dart';
import 'package:ira_app/screens/register/component/body.dart';

class RegisterScreen extends StatelessWidget {
  static String routeName = '/register';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Бүртгүүлэх'),
      ),
      body: Body(),
    );
  }
}
