import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ira_app/components/custom_surfix_icon.dart';
import 'package:ira_app/components/default_button.dart';
import 'package:ira_app/components/form_error.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/controller/AuthService.dart';
import 'package:ira_app/screens/home_screen/home_screen.dart';
import 'package:ira_app/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginForm extends StatefulWidget {
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  String email;
  String password;
  bool isLoading = false;

  final List<String> errors = [];

  void addError({String error}) {
    if (!errors.contains(error))
      setState(() {
        errors.add(error);
      });
  }

  void removeError({String error}) {
    if (errors.contains(error))
      setState(() {
        errors.remove(error);
      });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(height: getProportionateScreenHeight(30)),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              GestureDetector(
                onTap: null,
                child: Text(
                  "Нууц үг сэргээх",
                  style: TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          FormError(errors: errors),
          SizedBox(height: getProportionateScreenHeight(20)),
          DefaultButton(
            text: "Нэвтрэх",
            press: isLoading
                ? null
                : () {
                    if (_formKey.currentState.validate()) {
                      _formKey.currentState.save();
                      //   // if all are valid then go to success screen
                      _handleSignIn(context);
                    }
                  },
          ),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kPassNullError);
          return "";
        } else if (value.length >= 8) {
          // removeError(error: kShortPassError);
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          // addError(error: kPassNullError);
          return "Нууц үгээ оруулна уу!";
        } else if (value.length < 8) {
          // addError(error: kShortPassError);
          return "нууц үг урт бага байна";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Нууц үг",
        hintText: "****",
        hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          // removeError(error: kEmailNullError);
          return "";
        } else if (emailValidatorRegExp.hasMatch(value)) {
          return "";
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          // addError(error: kEmailNullError);
          return "Цахим хаягаа оруулна уу!";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          // addError(error: kInvalidEmailError);
          return "Цахим хаяг байх ёстой";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Цахим хаяг",
        hintText: "цахим хаяг ...",
        hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/email.svg",
          color: Colors.grey,
        ),
      ),
    );
  }

  void _handleSignIn(context) async {
    setState(() {
      isLoading = true;
    });

    var data = {
      "email": email,
      "password": password,
    };
    var res = await AuthService().postData(data, 'user/login');

    if (res.statusCode == 200) {
      var body = json.decode(res.body);

      print("${body}");
      if (body['result'] == 'success') {
        print("${body}");
        SharedPreferences localStorage = await SharedPreferences.getInstance();
        localStorage.setString('token', body['token']);
        localStorage.setString('user', json.encode(body['user']));
        Navigator.pushReplacementNamed(context, HomeScreen.routeName);
      } else if (body['result'] == 'fail') {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              "Амжилтгүй",
              textAlign: TextAlign.center,
            ),
            elevation: 5.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            actions: <Widget>[
              new RaisedButton(
                  elevation: 1.0,
                  color: kPrimaryColor,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  child: new Text(
                    "Ok",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () => Navigator.of(context).pop()),
            ],
            content: Text(
              body['message'],
              style: TextStyle(fontSize: 12),
              textAlign: TextAlign.center,
            ),
          ),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            "Амжилтгүй",
            textAlign: TextAlign.center,
          ),
          elevation: 5.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          actions: <Widget>[
            new RaisedButton(
                elevation: 1.0,
                color: kPrimaryColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0)),
                child: new Text(
                  "Ok",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () => Navigator.of(context).pop()),
          ],
          content: Text(
            'error',
            style: TextStyle(fontSize: 12),
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    setState(() {
      isLoading = false;
    });
  }
}
