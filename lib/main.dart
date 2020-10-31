import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ira_app/Theme.dart';
import 'package:ira_app/routes.dart';
import 'package:ira_app/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  // landscape disable
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  SharedPreferences localstorage = await SharedPreferences.getInstance();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme(),
      initialRoute: LoginScreen.routeName,
      routes: routes,
    );
  }
}
