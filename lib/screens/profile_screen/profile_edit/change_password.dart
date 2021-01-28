import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import './widget/text_form_field.dart';

class ChangePasswordProfile extends StatefulWidget {
  _PasswordState createState() => _PasswordState();
}

class _PasswordState extends State<ChangePasswordProfile> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Нууц үг солих"),
        elevation: 1.0,
      ),
      backgroundColor: Color(0xFFF5F6F9),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                margin: EdgeInsets.all(20.0),
                child: BuildFormField(),
              )
            ],
          ),
          Positioned(
              bottom: 0,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.white),
                child: Center(
                  child: ButtonTheme(
                    minWidth: MediaQuery.of(context).size.width,
                    child: RaisedButton(
                      elevation: 5.0,
                      color: kPrimaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                      onPressed: () {},
                      child: Text(
                        'Хадгалах',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
