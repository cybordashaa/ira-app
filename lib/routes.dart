import 'package:flutter/material.dart';
import 'package:ira_app/screens/chat_screen/chat_screen.dart';
import 'package:ira_app/screens/home_screen/home_screen.dart';
import 'package:ira_app/screens/login_screen/login_screen.dart';
import 'package:ira_app/screens/register/register_screen.dart';

final Map<String, WidgetBuilder> routes = {
  LoginScreen.routeName: (context) => LoginScreen(),
  RegisterScreen.routeName: (context) => RegisterScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ChatScreen.routeName: (context) => ChatScreen()
};
