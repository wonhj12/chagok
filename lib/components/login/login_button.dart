import 'package:chagok/utils/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LoginButton extends StatelessWidget {
  final String icon;
  final String text;
  final Color background;
  final Function()? onTap;
  const LoginButton({
    super.key,
    required this.icon,
    required this.text,
    required this.background,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Ink(
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(10),
        ),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: double.infinity,
            height: 48,
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset(
                  'assets/icons/$icon',
                  width: 20,
                  height: 20,
                ),
                Text(
                  text,
                  style: Palette.callout.copyWith(fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 20)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
