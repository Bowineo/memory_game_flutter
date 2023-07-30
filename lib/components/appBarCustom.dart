import 'package:flutter/material.dart';
import '../constants/textStyle.dart';
import '../constants/colors.dart';

class AppBarCustom extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final bool implyLeading;
  final Widget? score;

  AppBarCustom({
    Key? key,
    required this.title,
    required this.implyLeading,
    this.score,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: implyLeading,
      centerTitle: true,
      title: score != null ? score : Text(
        title,
        style: textAux,
      ),
      backgroundColor: primaryColor,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
