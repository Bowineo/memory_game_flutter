import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../components/buttonCustomMenu.dart';
import '../constants/colors.dart';
import '../constants/constants.dart';
import '../constants/helpers.dart';
import '../screens/Records.dart';
import '../components/appBarCustom.dart';
import '../components/drawerCustom.dart';
import '../constants/textStyle.dart';

class MenuScreen extends StatefulWidget {
  MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  List<String> highScores = [];
  @override
  void initState() {
    _loadHighScores();
    super.initState();
  }

  void _loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedHighScores = prefs.getStringList('highScores');
    if (savedHighScores != null) {
      highScores = savedHighScores;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: kTitle,
        implyLeading: true,
      ),
      drawer: DrawerCustom(
          fncOne: goToHighScoresScreen,
          fncTwo: exitApp,
          textOne: 'Melhores Pontuações',
          textTwo: 'Sair',
          textTitle: kTitle),
      body: Container(
        color: backgroundColor,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  kTextMenu,
                  style: textMenu,
                ),
                ButtonCustomMenu(
                  textButton: kThemeGame(0),
                ),
                ButtonCustomMenu(
                  textButton: kThemeGame(1),
                ),
                ButtonCustomMenu(
                  textButton: kThemeGame(2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void goToHighScoresScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => HighScoresScreen(
          highScores: highScores,
        ),
      ),
    );
  }
}
