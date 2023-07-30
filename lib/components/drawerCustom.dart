import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../constants/textStyle.dart';
import '../constants/colors.dart';

class DrawerCustom extends StatelessWidget {
  Function? fncOne;
  Function? fncTwo;
  Function? fncThree;
  String textTitle;
  String? textOne;
  String? textTwo;
  String? textThree;

  DrawerCustom({
    Key? key,
    this.fncOne,
    this.fncTwo,
    this.fncThree,
    this.textOne,
    this.textTwo,
    required this.textTitle,
    this.textThree,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: backgroundColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: primaryColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CircleAvatar(
                  backgroundColor: backgroundColor,
                  backgroundImage: AssetImage(kLogo),
                  radius: 40,
                ),
                Text(
                  textTitle,
                  style: textAux,
                ),
              ],
            ),
          ),
          textOne != null || fncOne != null
              ? ListTile(
                  title: Text(
                    textOne!,
                    style: textDrawer,
                  ),
                  onTap: () {
                    fncOne!();
                  },
                )
              : Container(),
          textTwo != null || fncTwo != null
              ? ListTile(
                  title: Text(
                    textTwo!,
                    style: textDrawer,
                  ),
                  onTap: () {
                    fncTwo!();
                  },
                )
              : Container(),
          textThree != null || fncThree != null
              ? ListTile(
                  title: Text(
                    textThree!,
                    style: textDrawer,
                  ),
                  onTap: () {
                    fncThree!();
                  },
                )
              : Container(),
        ],
      ),
    );
  }
}
