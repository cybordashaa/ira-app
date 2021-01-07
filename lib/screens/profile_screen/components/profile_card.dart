import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ira_app/constants.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard(
      {Key key,
      this.walletText,
      this.durationText,
      @required this.walletIcon,
      @required this.durationIcon})
      : super(key: key);
  final String walletText;
  final String durationText;
  final String walletIcon;
  final String durationIcon;
  @override
  Widget build(BuildContext context) {
    return Container(
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
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(1.0),
                  child: SvgPicture.asset(
                    walletIcon,
                    width: 15,
                    color: kPrimaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text(
                    "Хэтэвч үлдэгдэл:",
                    style:
                        TextStyle(fontSize: 12, fontFamily: 'Raleway-Regular'),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: EdgeInsets.only(left: 120),
                    child: Text(walletText != null ? walletText : '0',
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Raleway-Regular',
                            color: Colors.black)),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.all(1),
                  child: SvgPicture.asset(
                    durationIcon,
                    width: 15,
                    color: kPrimaryColor,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: Text("Үйлчилгээ дуусах хугацаа:",
                      style: TextStyle(
                          fontSize: 12, fontFamily: 'Raleway-Regular')),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.only(left: 70.0),
                      child: Text(durationText != null ? durationText : "-",
                          style: TextStyle(
                              fontSize: 12,
                              fontFamily: 'Raleway-Regular',
                              color: Colors.black))),
                )
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Row(
              children: [
                Padding(
                    padding: EdgeInsets.all(5),
                    child: FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                          side: BorderSide(color: Color(0xFFF5F6F9))),
                      onPressed: () {},
                      child: Text("үйлчилгээ цуцлах",
                          style: TextStyle(
                              fontSize: 11,
                              fontFamily: 'Raleway-Regular',
                              color: Colors.black87)),
                    )),
                Expanded(
                  flex: 2,
                  child: Padding(
                      padding: EdgeInsets.only(left: 50.0),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        color: Color(0xFFF5F6F9),
                        onPressed: () {},
                        child: Text("Үйлчилгээ Сунгах",
                            style: TextStyle(
                                fontSize: 11,
                                fontFamily: 'Raleway-Regular',
                                color: Color(0xFF22A1AD))),
                      )),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
