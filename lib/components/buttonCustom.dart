import 'package:flutter/material.dart';
import '../constants/buttonStyle.dart';
import '../constants/textStyle.dart';

class ButtonCustom extends StatefulWidget {
  final String textButton;
  final Function fnc;

  ButtonCustom({
    Key? key,
    required this.textButton,
    required this.fnc,
  }) : super(key: key);

  @override
  State<ButtonCustom> createState() => _ButtonCustomState();
}

class _ButtonCustomState extends State<ButtonCustom> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ElevatedButton(
        style: styleButtonMenuCustom,
        onPressed: () {
          widget.fnc();
        },
        child: Text(
          widget.textButton,
          style: textAux,
        ),
      ),
    );
  }
}
