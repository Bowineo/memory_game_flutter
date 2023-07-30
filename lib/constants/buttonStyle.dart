import 'package:flutter/material.dart';
import 'colors.dart';
import 'textStyle.dart';

ButtonStyle styleButtonMenuCustom = ElevatedButton.styleFrom(
  primary: primaryColor,
  padding: const EdgeInsets.symmetric(
    horizontal: 20,
    vertical: 20,
  ),
  textStyle: textAux,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(8),
  ),
);
