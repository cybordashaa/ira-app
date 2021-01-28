import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import './widget/text_form_field.dart';

class EditRegister extends StatefulWidget {
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<EditRegister> {
  RegExp regExp = new RegExp(
    r"^[А-ЯӨҮЁ]{2}(\d){8}$",
    caseSensitive: false,
    multiLine: false,
  );
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String registerNumber;

  void addError({String error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          elevation: 1.0,
          title: Text("Ригестрийн дугаар солих"),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  margin: EdgeInsets.all(20.0),
                  child: BuildFormField(
                      labelText: "Ригестрийн дугаар",
                      isError: false,
                      savedValue: registerNumber),
                ),
              ],
            ),
            Positioned(
                bottom: 0,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                  ),
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
                  )),
                ))
          ],
        ));
  }
}
