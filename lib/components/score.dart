import 'package:flutter/material.dart';
import '../constants/constants.dart';
import '../constants/textStyle.dart';

class Score extends StatelessWidget {
  const Score({
    Key? key,
    required this.score,
  }) : super(key: key);

  final int score;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Text(
        '$kScore $score',
        style: textScore(score),
      ),
    );
  }
}
