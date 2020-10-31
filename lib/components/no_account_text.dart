import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/screens/register/register_screen.dart';
import 'package:ira_app/size_config.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Бүртгэл шинээр үүсгэх ?",
          style: TextStyle(fontSize: getProportionateScreenWidth(16)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, RegisterScreen.routeName);
          },
          child: Text(
            "Бүртгүүлэх",
            style: TextStyle(
                fontSize: getProportionateScreenWidth(16),
                color: kPrimaryColor),
          ),
        )
      ],
    );
  }
}
