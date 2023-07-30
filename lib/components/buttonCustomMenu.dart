import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../constants/buttonStyle.dart';
import '../constants/textStyle.dart';
import '../screens/MemoryGame.dart';

class ButtonCustomMenu extends StatefulWidget {
  final String textButton;
  final Function? fnc;

  ButtonCustomMenu({
    Key? key,
    required this.textButton,
    this.fnc,
  }) : super(key: key);

  @override
  State<ButtonCustomMenu> createState() => _ButtonCustomMenuState();
}

class _ButtonCustomMenuState extends State<ButtonCustomMenu> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: styleButtonMenuCustom,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MemoryGame(
                themeSelection: kGetThemeGame(widget.textButton),
              ),
            ),
          );
        },
        child: Text(
          widget.textButton,
          style: textAux,
        ),
      ),
    );
  }
}
