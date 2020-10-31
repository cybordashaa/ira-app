import 'package:flutter/material.dart';
import 'package:ira_app/constants.dart';
import 'package:ira_app/screens/register/component/register_form.dart';
import 'package:ira_app/size_config.dart';

class Body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: getProportionateScreenWidth(50)),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: SizeConfig.screenHeight * 0.08),
                // Text(
                //   'Бүртгэл үүсгэх',
                //   style: headingStyle,
                // ),
                // SizedBox(height: SizeConfig.screenHeight * 0.08),
                RegisterForm()
              ],
            ),
          ),
        ),
      ),
    );
  }
}
