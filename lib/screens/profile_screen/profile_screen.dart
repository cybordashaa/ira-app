import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import './components/body.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _lastname;
  int _wallet;
  _ProfileScreenState() {
    loadSharedPrefs();
  }
  loadSharedPrefs() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();

      setState(() {
        _lastname = prefs.getString('lastname');
        _wallet = prefs.getInt('wallet');
      });
    } catch (er) {
      print(" profile error: ${er.toString()}");
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Body(
      lastname: _lastname,
      wallet: _wallet,
    );
  }
}
