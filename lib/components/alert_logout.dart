import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/screens/login_screen/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum DialogAction { yes, abort }

class Dialogs {
  static Future<DialogAction> yesAbortDialog(
      BuildContext context, String title, String body) async {
    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            title: Text(title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
            content: Text(
              body,
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              FlatButton(
                onPressed: () => Navigator.of(context).pop(DialogAction.abort),
                child: const Text(
                  "Үгүй",
                  style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF575151),
                      fontFamily: 'Raleway'),
                ),
              ),
              FlatButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(color: kPrimaryColor)),
                onPressed: () async {
                  // logout from the server ...
                  SharedPreferences localStorage =
                      await SharedPreferences.getInstance();
                  await localStorage.clear();
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                          builder: (BuildContext context) => LoginScreen()),
                      (Route<dynamic> route) => false);
                },
                child: const Text("Тийм",
                    style: TextStyle(
                      color: Color(0xFF575151),
                      fontFamily: 'Raleway',
                      fontSize: 12,
                    )),
              )
            ],
          );
        });
    return (action != null) ? action : DialogAction.abort;
  }
}
