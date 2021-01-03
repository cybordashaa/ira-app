import 'package:flutter/material.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    _menuItem(String title, IconData iconData, LinearGradient gradient,
        Function press) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: press,
        child: Container(
          height: MediaQuery.of(context).size.width * 0.28,
          width: MediaQuery.of(context).size.width * 0.26,
          margin: EdgeInsets.all(4),
          padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                spreadRadius: 2,
                blurRadius: 10,
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(18),
                child: Center(
                  child: Icon(iconData, size: 20, color: Colors.white),
                ),
                decoration: BoxDecoration(
                  gradient: gradient,
                  shape: BoxShape.circle,
                ),
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      );
    }

    // TODO: implement build
    return Padding(
      padding: EdgeInsets.all(5.0),
      child: SingleChildScrollView(
        padding: EdgeInsets.only(left: 16, top: 54, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _menuItem(
                    'Үндсэн үйлчилгээ',
                    Icons.home_repair_service,
                    LinearGradient(
                      colors: [
                        Color(0xFF008197),
                        Color(0XFF12dae0),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ), () {
                  print("clicked main ...");
                }),
                _menuItem(
                    'Нэмэлт үйлчилгээ',
                    Icons.medical_services,
                    LinearGradient(
                      colors: [
                        Color(0xFF008197),
                        Color(0XFF12dae0),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ), () {
                  print("clicked add service ...");
                }),
                _menuItem(
                    'IRA хэтэвч',
                    Icons.account_balance_wallet,
                    LinearGradient(
                      colors: [
                        Color(0xFF008197),
                        // Color(0XFF74d9d0),
                        Color(0XFF12dae0)
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ), () {
                  print("clicked wallet ...");
                }),
              ],
            ),
            SizedBox(
              height: 12,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _menuItem(
                    'Online storage coming soon...',
                    Icons.storage,
                    LinearGradient(
                      colors: [
                        Color(0xFF008197),
                        Color(0XFF12dae0),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    null),
                _menuItem(
                    'IRA TV coming soon...',
                    Icons.tv,
                    LinearGradient(
                      colors: [
                        Color(0xFF008197),
                        Color(0XFF12dae0),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    null),
                _menuItem(
                    'IRA Shoppy coming soon...',
                    Icons.shopping_basket,
                    LinearGradient(
                      colors: [
                        Color(0xFF008197),
                        Color(0XFF12dae0),
                      ],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                    ),
                    null),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
