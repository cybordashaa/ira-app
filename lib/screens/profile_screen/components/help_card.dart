import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ira_app/constants.dart';

class HelpCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20),
      padding: new EdgeInsets.only(left: 0, bottom: 8.0, right: 0),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
                color: Theme.of(context).focusColor.withOpacity(0.05),
                blurRadius: 2,
                offset: Offset(0, 3))
          ]),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              print("1");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 1),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(1.0),
                    child: SvgPicture.asset(
                      "assets/icons/wallet.svg",
                      width: 15,
                      color: kPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 10, top: 10.0, bottom: 5, right: 10),
                    child: Text(
                      "Хэтэвч үлдэгдэл:",
                      style: TextStyle(
                          fontSize: 12, fontFamily: 'Raleway-Regular'),
                    ),
                  ),
                ],
              ),
            ),
          ),
          FlatButton(
            colorBrightness: Brightness.dark,
            splashColor: kPrimaryColor,
            onPressed: () {
              print("2");
            },
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 5, vertical: 1),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(1),
                    child: SvgPicture.asset(
                      "assets/icons/calendar.svg",
                      width: 15,
                      color: kPrimaryColor,
                    ),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 2.0),
                    child: Text("Үйлчилгээ дуусах хугацаа:",
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Raleway-Regular',
                            color: kTextColor)),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
