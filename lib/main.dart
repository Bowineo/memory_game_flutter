import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../screens/MenuScreen.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    color: primaryColor,
    home: MenuScreen(),
  ));
}
