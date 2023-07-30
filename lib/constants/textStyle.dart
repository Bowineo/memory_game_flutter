import 'package:flutter/material.dart';
import '../constants/colors.dart';

TextStyle textDefault = TextStyle(
  color: primaryColor,
  fontFamily: 'Boogaloo',
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
  fontSize: 16,
);

TextStyle textDrawer = TextStyle(
  color: primaryColor,
  fontFamily: 'Boogaloo',
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
  fontSize: 24,
);


TextStyle textMenu = TextStyle(
  color: primaryColor,
  fontFamily: 'Boogaloo',
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
  fontSize: 32,
);

TextStyle textAux = const TextStyle(
  color: Colors.white,
  fontFamily: 'Boogaloo',
  fontSize: 24,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);

TextStyle textScore(int themeSelection) {
  return TextStyle(
    color: themeSelection.isNegative ? scoreNegativeColor : scorePositiveColor,
    fontFamily: 'Boogaloo',
    fontSize: 24,
    fontWeight: FontWeight.bold,
    fontStyle: FontStyle.normal,
  );
}

TextStyle textQuestion = const TextStyle(
  color: questionColor,
  fontFamily: 'Boogaloo',
  fontSize: 24,
  fontWeight: FontWeight.bold,
  fontStyle: FontStyle.normal,
);


