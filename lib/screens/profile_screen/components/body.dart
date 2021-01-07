import 'package:flutter/material.dart';
import 'package:ira_app/components/alert_logout.dart';
import 'package:ira_app/screens/profile_screen/more_screen/profile_detail.dart';
import './profile_pic.dart';
import './profile_menu_data.dart';
import './profile_card.dart';
import 'card_info_service.dart';

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
      child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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
              CardInfoService(),
              // ProfileCard(
              //   walletIcon: "assets/icons/wallet.svg",
              //   durationIcon: "assets/icons/calendar.svg",
              //   walletText: '${wallet != null ? wallet : 0}',
              //   durationText: "2020/12/12 2021/12/12",
              // ),
              SizedBox(
                height: 3.0,
              ),
              ProfileMenu(
                text: 'Хувийн мэдээлэл',
                icon: "assets/icons/user.svg",
                iconLogo: Icons.arrow_forward_ios_sharp,
                press: () {
                  Navigator.of(context).push(new MaterialPageRoute(
                      builder: (context) => new ProfileDetail()));
                  // Navigator.pushNamed(context, '/profileDetail');
                },
              ),
              ProfileMenu(
                  text: 'Тохиргоо',
                  icon: "assets/icons/gear.svg",
                  iconLogo: Icons.arrow_forward_ios_sharp,
                  press: () {}),
              ProfileMenu(
                  text: 'Тусламж',
                  icon: "assets/icons/support.svg",
                  iconLogo: Icons.arrow_forward_ios_sharp,
                  press: () {}),
              ProfileMenu(
                text: 'Гарах',
                icon: "assets/icons/shutdown.svg",
                press: () {
                  Dialogs.yesAbortDialog(
                      context, 'Асуулт', 'Та гарахдаа итгэлтэй байна уу?');
                },
              ),
            ],
          )),
    );
  }
}
