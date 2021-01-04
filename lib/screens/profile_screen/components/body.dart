import 'package:flutter/material.dart';
import 'package:ira_app/components/alert_logout.dart';
import './profile_pic.dart';
import './profile_menu_data.dart';
import './profile_card.dart';

class Body extends StatelessWidget {
  final String lastname;
  final String avatar;
  final int wallet;
  Body({Key key, this.lastname, this.avatar, this.wallet}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 5),
      child: Column(
        children: [
          SizedBox(
            height: 40,
          ),
          ProfilePic(),
          Text(lastname != null ? lastname : ''),
          SizedBox(
            height: 20,
          ),
          ProfileCard(
            walletIcon: "assets/icons/wallet.svg",
            durationIcon: "assets/icons/calendar.svg",
            walletText: '${wallet != null ? wallet : 0}',
            durationText: "2020/12/12 2021/12/12",
          ),
          SizedBox(
            height: 3.0,
          ),
          ProfileMenu(
            text: 'Хувийн мэдээлэл',
            icon: "assets/icons/user.svg",
            press: () {},
          ),
          ProfileMenu(
              text: 'Тохиргоо', icon: "assets/icons/gear.svg", press: () {}),
          ProfileMenu(
              text: 'Тусламж', icon: "assets/icons/support.svg", press: () {}),
          ProfileMenu(
            text: 'Гарах',
            icon: "assets/icons/shutdown.svg",
            press: () {
              Dialogs.yesAbortDialog(
                  context, 'Асуулт', 'Та гарахдаа итгэлтэй байна уу?');
            },
            iconLogo: Icons.logout,
          ),
        ],
      ),
    );
  }
}
