import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ira_app/models/user_data.dart';
import 'package:ira_app/provider/profile_provider.dart';
import 'package:provider/provider.dart';

class ProfileDetail extends StatelessWidget {
  static String routeName = '/profileDetail';
  ProfileDetail({Key key, this.title}) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
        backgroundColor: Color(0xFFF5F6F9),
        appBar: AppBar(
          elevation: 1.0,
          title: Text('Хувийн мэдээлэл'),
        ),
        body: Consumer<ProfileProvider>(
          builder: (context, profile, child) {
            return profile.loading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: _buildCard(profile.userData),
                  );
          },
        ));
  }

  Widget _buildCard(UserData profile) {
    var isRegister = profile.register != null && profile.register != '';
    var isFirstName = profile.firstname != null && profile.firstname != '';
    var isLastName = profile.lastname != null && profile.lastname != '';
    var isEmail = profile.email != null && profile.email != '';
    var isPhone = profile.phone != null && profile.phone != '';
    var isAddress = profile.address != null && profile.address != '';

    return Container(
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 10.0),
        elevation: 0.0,
        child: Column(
          children: [
            isFirstName
                ? ListTile(
                    title: Text('Овог', style: TextStyle(fontSize: 16)),
                    subtitle: Text(
                      '${profile.firstname}',
                      style: TextStyle(fontSize: 14),
                    ),
                    leading: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/user-o.svg",
                        color: Color(0xFF22A1AD),
                      ),
                    ),
                  )
                : Container(),
            Divider(),
            isLastName
                ? ListTile(
                    title: Text('Нэр', style: TextStyle(fontSize: 16)),
                    subtitle: Text('${profile.lastname}',
                        style: TextStyle(fontSize: 14)),
                    leading: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/user-o.svg",
                        color: Color(0xFF22A1AD),
                      ),
                    ),
                  )
                : Container(),
            isEmail
                ? ListTile(
                    title: Text('Цахим хаяг', style: TextStyle(fontSize: 16)),
                    subtitle: Text('${profile.email}',
                        style: TextStyle(fontSize: 14)),
                    leading: SizedBox(
                      height: 25,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/email.svg",
                        color: Color(0xFF22A1AD),
                      ),
                    ),
                  )
                : Container(),
            isPhone
                ? ListTile(
                    title: Text(
                      'Утасны дугаар',
                    ),
                    subtitle: Text('${profile.phone}'),
                    leading: SizedBox(
                      height: 25,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/phone.svg",
                        color: Color(0xFF22A1AD),
                      ),
                    ))
                : Container(),
            isAddress
                ? ListTile(
                    title: Text('Хаяг'),
                    subtitle: Text('${profile.address}'),
                    leading: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/location.svg",
                        color: Color(0xFF22A1AD),
                      ),
                    ),
                  )
                : Container(),
            Divider(),
            isRegister
                ? ListTile(
                    title: Text('Ригестрийн дугаар'),
                    leading: SizedBox(
                      height: 30,
                      width: 30,
                      child: SvgPicture.asset(
                        "assets/icons/card.svg",
                        color: Color(0xFF22A1AD),
                      ),
                    ),
                    subtitle: Text('${profile.register}'),
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
