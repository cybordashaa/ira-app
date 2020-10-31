import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ira_app/size_config.dart';

class CustomSurffixIcon extends StatelessWidget {
  const CustomSurffixIcon({Key key, @required this.svgIcon, this.color})
      : super(key: key);
  final String svgIcon;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return new Padding(
        padding: EdgeInsets.fromLTRB(0, getProportionateScreenWidth(20),
            getProportionateScreenWidth(20), getProportionateScreenWidth(20)),
        child: SvgPicture.asset(
          svgIcon,
          height: getProportionateScreenHeight(18),
          color: color,
        ));
  }
}
