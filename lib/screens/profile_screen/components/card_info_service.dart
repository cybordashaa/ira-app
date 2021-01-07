import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ira_app/constants.dart';

class CardInfoService extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      width: 500,
      height: 190,
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(14))),
      child: Column(
        children: <Widget>[
          // Row(
          //   children: <Widget>[
          //     Icon(Icons.motorcycle, color: Colors.orange, size: 25),
          //     SizedBox(width: 10),
          //     Text("Jet Airways",
          //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          //     SizedBox(width: 110),
          //     Text("\$999",
          //         style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          //     // SizedBox(width: 15),
          //     Icon(Icons.trending_flat, color: Colors.black, size: 20)
          //   ],
          // ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _itemDepartment(),
              // _locationPlane(),
              _itemDepartment2(),
            ],
          ),
          SizedBox(
            height: 40.0,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [_button1(), _button2()],
          )
        ],
      ),
    );
  }
}

Widget _button1() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.0,
        ),
        FlatButton(
          minWidth: 150,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
              side: BorderSide(color: Colors.grey, width: 0.0)),
          // color: Color(0xFFF5F6F9),
          onPressed: () {},
          child: Text('Үйлчилгээг цуцлах',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)),
        ),
      ],
    ),
  );
}

Widget _button2() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 10.0,
        ),
        ButtonTheme(
          minWidth: 150,
          child: RaisedButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.0),
            ),
            color: Color(0xFFF5F6F9),
            onPressed: () {},
            child: Text('Үйлчилгээг сунгах',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: kPrimaryColor)),
          ),
        ),
      ],
    ),
  );
}

Widget _itemDepartment() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            SizedBox(
              height: 15,
              width: 15,
              child: SvgPicture.asset(
                'assets/icons/wallet.svg',
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text("Хэтэвч үлдэгдэл",
                style: TextStyle(color: Colors.black54, fontSize: 13)),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 23.0,
            ),
            Text("2000.00 ₮",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
          ],
        ),
        SizedBox(height: 1),
        // Text("JFK",
        //     style: TextStyle(
        //       color: Colors.black54,
        //     )),
      ],
    ),
  );
}

Widget _itemDepartment2() {
  return Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Row(
          children: [
            SizedBox(
              height: 15,
              width: 15,
              child: SvgPicture.asset(
                'assets/icons/calendar.svg',
                color: kPrimaryColor,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text("Үйлчилгээ дуусах хугацаа",
                style: TextStyle(color: Colors.black54, fontSize: 13)),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 23.0,
            ),
            Text("2020-12-12",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
            SizedBox(
              width: 5.0,
            ),
            Icon(Icons.trending_flat, color: Colors.black, size: 15),
            SizedBox(
              width: 5.0,
            ),
            Text("2020-12-12",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 12)),
          ],
        ),
        SizedBox(height: 1),
        // Text("SFO", style: TextStyle(color: Colors.black54)),
      ],
    ),
  );
}
