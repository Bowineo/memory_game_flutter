import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';
import '../constants/helpers.dart';
import '../constants/textStyle.dart';
import '../components/appBarCustom.dart';

class HighScoresScreen extends StatefulWidget {
  late List<String> highScores;
  HighScoresScreen({required this.highScores});
  @override
  State<HighScoresScreen> createState() => _HighScoresScreenState();
}

class _HighScoresScreenState extends State<HighScoresScreen> {
  @override
  void dispose() {
    _saveHighScores();
    super.dispose();
  }

  @override
  void initState() {
    _loadHighScores();
    super.initState();
  }

  void _saveHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('highScores', widget.highScores);
  }

  void _loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedHighScores = prefs.getStringList('highScores');
    if (savedHighScores != null) {
      setState(() {
        widget.highScores = orderList(savedHighScores);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: kRecords,
        implyLeading: true,
      ),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(40, 8, 40, 8),
            child: ListView.builder(
              itemCount: widget.highScores.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    '${index + 1}° ${widget.highScores[index]}',
                    style: textDefault,
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
