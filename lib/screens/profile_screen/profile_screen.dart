import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/provider/profile_provider.dart';
import 'package:provider/provider.dart';
import './components/body.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  // String _lastname;
  // int _wallet;
  // _ProfileScreenState() {
  //   loadSharedPrefs();
  // }
  // loadSharedPrefs() async {
  //   try {
  //     SharedPreferences prefs = await SharedPreferences.getInstance();

  //     setState(() {
  //       _lastname = prefs.getString('lastname');
  //       _wallet = prefs.getInt('wallet');
  //     });
  //   } catch (er) {
  //     print(" profile error: ${er.toString()}");
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileProvider>(builder: (context, profile, child) {
      return profile.loading
          ? Center(
              child: CircularProgressIndicator(
                  valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor)),
            )
          : Body(
              lastname: profile.userData.lastname,
              wallet: profile.userData.wallet,
            );
    });
  }
}
