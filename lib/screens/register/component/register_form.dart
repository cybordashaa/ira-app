import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:ira_app/components/custom_surfix_icon.dart';
import 'package:ira_app/components/default_button.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/service/AuthService.dart';
import 'package:ira_app/size_config.dart';

class RegisterForm extends StatefulWidget {
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final List<String> errors = [];
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;

  FocusNode passwordFocus;
  FocusNode lastNameNodeFocus;
  FocusNode emailNodeFocus;
  FocusNode firstNameNodeFocus;
  FocusNode phoneNumberNodeFocus;
  // register state
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    passwordFocus = FocusNode();
    lastNameNodeFocus = FocusNode();
    emailNodeFocus = FocusNode();
    firstNameNodeFocus = FocusNode();
    phoneNumberNodeFocus = FocusNode();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    passwordFocus.dispose();
    lastNameNodeFocus.dispose();
    emailNodeFocus.dispose();
    firstNameNodeFocus.dispose();
    phoneNumberNodeFocus.dispose();
  }

  void _requestFocus(FocusNode focusNode) {
    setState(() {
      FocusScope.of(context).requestFocus(focusNode);
    });
  }

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
    return Form(
      key: _formKey,
      child: Column(
        children: [
          buildLastNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildFirstNameFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPhoneNumberFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildEmailFormField(),
          SizedBox(
            height: getProportionateScreenHeight(30),
          ),
          buildPasswordFormField(),
          SizedBox(
            height: getProportionateScreenHeight(10),
          ),
          // FormError(errors: errors),
          // SizedBox(
          //   height: getProportionateScreenHeight(20),
          // ),
          Padding(
              padding: EdgeInsets.only(bottom: 20),
              child: DefaultButton(
                text: "Бүртгүүлэх",
                press: isLoading
                    ? null
                    : () {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          _handleSignUp(context);
                          //   // if all are valid then go to success screen
                          //   // Navigator.pushNamed(context, LoginSuccessScreen.routeName);
                          // print(databaseHelper.signUp(
                          //     firstName.trim(),
                          //     lastName.trim(),
                          //     email.trim(),
                          //     password.trim(),
                          //     phoneNumber.trim()));
                        }
                      },
              )),
        ],
      ),
    );
  }

  TextFormField buildPasswordFormField() {
    return TextFormField(
      focusNode: passwordFocus,
      onTap: () => _requestFocus(passwordFocus),
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        password = value;
      },
      validator: (value) {
        if (value.isEmpty) {
          // addError(error: kPassNullError);
          return "нууц үгээ оруулна уу!";
        } else if (value.length < 6) {
          // addError(error: kShortPassError);
          return "нууц үг урт богино байна";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Нууц үг",
        labelStyle: TextStyle(
            color: passwordFocus.hasFocus ? kPrimaryColor : kTextColor),
        hintText: "****",
        hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/Lock.svg",
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      focusNode: emailNodeFocus,
      onTap: () => _requestFocus(emailNodeFocus),
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
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
          labelStyle: TextStyle(
              color: emailNodeFocus.hasFocus ? kPrimaryColor : kTextColor),
          hintText: "Цахим хаяг ...",
          hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
          // If  you are using latest version of flutter then lable text and hint text shown like this
          // if you r using flutter less then 1.20.* then maybe this is not working properly
          floatingLabelBehavior: FloatingLabelBehavior.always,
          suffixIcon: emailNodeFocus.hasFocus
              ? CustomSurffixIcon(
                  svgIcon: "assets/icons/email.svg",
                  color: kPrimaryColor,
                )
              : CustomSurffixIcon(
                  svgIcon: "assets/icons/email.svg",
                  color: Colors.grey,
                )),
    );
  }

  TextFormField buildPhoneNumberFormField() {
    return TextFormField(
      focusNode: phoneNumberNodeFocus,
      onTap: () => _requestFocus(phoneNumberNodeFocus),
      keyboardType: TextInputType.number,
      onSaved: (newValue) => phoneNumber = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPhoneNumberNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          // addError(error: kPhoneNumberNullError);
          return "утасны дугаар оруулна уу!";
        } else if (value.length < 8) {
          // addError(error: kShortPassError);
          return "утасны дугаар урт бага байна!";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Утасны дугаар",
        labelStyle: TextStyle(
            color: phoneNumberNodeFocus.hasFocus ? kPrimaryColor : kTextColor),
        hintText: "утасны дугаар ...",
        hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: phoneNumberNodeFocus.hasFocus
            ? CustomSurffixIcon(
                svgIcon: "assets/icons/phone.svg",
                color: kPrimaryColor,
              )
            : CustomSurffixIcon(
                svgIcon: "assets/icons/phone.svg",
                color: Colors.grey,
              ),
      ),
    );
  }

  TextFormField buildFirstNameFormField() {
    return TextFormField(
      focusNode: firstNameNodeFocus,
      onTap: () => _requestFocus(firstNameNodeFocus),
      keyboardType: TextInputType.text,
      onSaved: (newValue) => firstName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kFirstNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          // addError(error: kFirstNameNullError);
          return "Нэрээ оруулна уу!";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Нэр",
        labelStyle: TextStyle(
            color: firstNameNodeFocus.hasFocus ? kPrimaryColor : kTextColor),
        hintText: "нэр ...",
        hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/user-o.svg",
          color: Colors.grey,
        ),
      ),
    );
  }

  TextFormField buildLastNameFormField() {
    return TextFormField(
      focusNode: lastNameNodeFocus,
      onTap: () => _requestFocus(lastNameNodeFocus),
      keyboardType: TextInputType.text,
      onSaved: (newValue) => lastName = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kLastNameNullError);
        }
        return null;
      },
      validator: (value) {
        if (value.isEmpty) {
          // addError(error: kLastNameNullError);
          return "Овгоо оруулна уу!";
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: "Овог",
        labelStyle: TextStyle(
            color: lastNameNodeFocus.hasFocus ? kPrimaryColor : kTextColor),
        hintText: "овог ...",
        hintStyle: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w300),
        // If  you are using latest version of flutter then lable text and hint text shown like this
        // if you r using flutter less then 1.20.* then maybe this is not working properly
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: CustomSurffixIcon(
          svgIcon: "assets/icons/user-o.svg",
          color: Colors.grey,
        ),
      ),
    );
  }

  void _handleSignUp(context) async {
    setState(() {
      isLoading = true;
    });

    var data = {
      "firstname": firstName,
      "lastname": lastName,
      "email": email,
      "password": password,
      "phone": phoneNumber
    };
    try {
      var res = await AuthService().postData(data, '/user/register');

      if (res.statusCode == 200) {
        var body = json.decode(res.body);
        if (body['result'] == 'success') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                "Амжилттай",
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
                "${body['message']} та нэвтэрч орно уу!",
                style: TextStyle(fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          );
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
              "error",
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
    } on TimeoutException catch (error) {
      print("--timeout exception");
      Fluttertoast.showToast(
        msg: "${error.message}",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
      );
    } on SocketException catch (error) {
      print("--socket exception");
      if (error.message.toString() == 'Connection failed'.trim()) {
        Fluttertoast.showToast(
          msg: "Интернет холболтоо шалгана уу!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 5,
        );
      } else {
        Fluttertoast.showToast(
          msg: " Холболтын алдаа!",
          toastLength: Toast.LENGTH_SHORT,
          timeInSecForIosWeb: 5,
        );
      }
    } catch (err) {
      print("--$err");
      Fluttertoast.showToast(
        msg: "алдаа гарлаа",
        toastLength: Toast.LENGTH_SHORT,
        timeInSecForIosWeb: 5,
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }

    setState(() {
      isLoading = false;
    });
  }
}
