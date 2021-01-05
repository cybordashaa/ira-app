import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ira_app/constants.dart';

class ProfileMenu extends StatelessWidget {
  const ProfileMenu(
      {Key key,
      @required this.text,
      @required this.icon,
      @required this.press,
      this.iconLogo})
      : super(key: key);

  final String text, icon;
  final VoidCallback press;
  final IconData iconLogo;

  @override
  Widget build(BuildContext context) {
    var isIconLogo = iconLogo != null;
    // TODO: implement build
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      child: FlatButton(
        padding: EdgeInsets.all(20),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        color: Colors.white,
        onPressed: press,
        child: Row(
          children: [
            SvgPicture.asset(
              icon,
              width: 22,
              color: kPrimaryColor,
            ),
            SizedBox(
              width: 20,
            ),
            Expanded(
                child: Text(
              text,
              // style: TextStyle(
              //     color: Colors.black54,
              //     fontFamily: 'Raleway',
              //     fontSize: 12,
              //     fontWeight: FontWeight.w600),
              style: Theme.of(context).textTheme.bodyText1,
            )),
            isIconLogo
                ? Icon(
                    iconLogo,
                    size: 18,
                  )
                : Container()
          ],
        ),
      ),
    );
  }
}
