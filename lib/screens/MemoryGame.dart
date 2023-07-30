import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show SchedulerBinding, timeDilation;
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/constants.dart';
import '../screens/MenuScreen.dart';
import '../screens/Records.dart';
import '../components/appBarCustom.dart';
import '../components/buttonCustom.dart';
import '../components/drawerCustom.dart';
import '../components/score.dart';
import '../constants/colors.dart';
import '../constants/helpers.dart';
import '../constants/lists.dart';
import '../constants/textStyle.dart';

class MemoryGame extends StatefulWidget {
  late int themeSelection;
  MemoryGame({
    Key? key,
    required this.themeSelection,
  }) : super(key: key);

  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> with TickerProviderStateMixin {
  List<int> visibleCards = [];
  List<int> matchedCards = [];
  List<bool> flippedCards = [];
  int score = 0;
  bool canFlipCard = true;
  late List<String> cards = [];
   List<String> highScores = [];
  TextEditingController _controllerSaveName = TextEditingController();
  AnimationController? _animationController;
  List<Animation<double>> _cardAnimations = [];

  void flipCard(int index) {
    if (!canFlipCard ||
        visibleCards.contains(index) ||
        matchedCards.contains(index)) {
      return;
    }

    setState(() {
      visibleCards.add(index);
      flippedCards[index] = true;
    });

    if (visibleCards.length == 2) {
      canFlipCard = false;

      Future.delayed(const Duration(seconds: 1), () {
        if (cards[visibleCards[0]] == cards[visibleCards[1]]) {
          setState(() {
            matchedCards.addAll(visibleCards);
            visibleCards = [];
            score += 10;
          });
        } else {
          setState(() {
            flippedCards[visibleCards[0]] = false;
            flippedCards[visibleCards[1]] = false;
            visibleCards = [];
            score -= 1;
          });
        }

        canFlipCard = true;
      });
    }
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

  void _saveHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('highScores', highScores);
  }

  void _loadHighScores() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String>? savedHighScores = prefs.getStringList('highScores');
    if (savedHighScores != null) {
      setState(() {
        highScores = savedHighScores;
      });
    }
  }

  void restartGame() {
    setState(() {
      visibleCards.clear();
      matchedCards.clear();
      _controllerSaveName.clear();
      score = 0;
      flippedCards = List.generate(cards.length, (index) => false);
      cards.shuffle(Random());
    });

    _saveHighScores();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ),
    );
  }

  void saveAndRestartGame() {
    String dateTime = dataNow();
    String name =
        _controllerSaveName.text.isNotEmpty ? _controllerSaveName.text : '';
    String _score = '$name - $score pontos ($dateTime)';

    setState(() {
      addScore(highScores, _score);
      visibleCards.clear();
      matchedCards.clear();
      _controllerSaveName.clear();
      score = 0;
      flippedCards = List.generate(cards.length, (index) => false);
      cards.shuffle(Random());
    });

    _saveHighScores();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MenuScreen(),
      ),
    );
  }

  @override
  void initState() {
    _loadHighScores();
    cards.clear();
    if (widget.themeSelection == 2) {
      List<String> _cards = getElementsRandom([...theme[0]]);
      _cards.addAll(getElementsRandom([...theme[1]]));
      cards = [..._cards, ..._cards];
    } else {
      cards = [
        ...theme[widget.themeSelection],
        ...theme[widget.themeSelection]
      ];
    }
    flippedCards = List.generate(cards.length, (index) => false);
    cards.shuffle(Random());

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );

    final totalCards = cards.length;
    for (int i = 0; i < totalCards; i++) {
      final animation = Tween<double>(
        begin: 0.0,
        end: 1.0,
      ).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Interval(
            i / totalCards,
            (i + 1) / totalCards,
            curve: Curves.easeOut,
          ),
        ),
      );

      _cardAnimations.add(animation);
    }

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    SchedulerBinding.instance!.addPostFrameCallback((_) {
      timeDilation = 1.5;
      _animationController!.forward();
    });
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: isLandscape(context)
          ? null
          : AppBarCustom(
              title: kTitle,
              score: matchedCards.length == 40
                  ? Text(
                      kTitle,
                      style: textAux,
                    )
                  : Score(score: score),
              implyLeading: true,
            ),
      drawer: isLandscape(context)
          ? null
          : DrawerCustom(
              fncOne: restartGame,
              fncTwo: goToHighScoresScreen,
              fncThree: exitApp,
              textOne: 'Reiniciar',
              textTwo: 'Melhores Pontuações',
              textThree: 'Sair',
              textTitle: kTitle),
      body: Container(
        color: backgroundColor,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            matchedCards.length == 40
                ? shouldAddScore(highScores, score)
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                '$kSaveName $score pontos!',
                                style: textMenu,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16),
                              child: TextField(
                                decoration: InputDecoration(
                                    hoverColor: primaryColor,
                                    fillColor: primaryColor,
                                    border: OutlineInputBorder(),
                                    labelText: 'Digite seu nome',
                                    labelStyle: textDefault),
                                controller: _controllerSaveName,
                                style: textDrawer,
                                textAlign: TextAlign.center,
                                maxLength: 16,
                              ),
                            ),
                            ButtonCustom(
                              textButton: 'Salvar',
                              fnc: saveAndRestartGame,
                            ),
                          ],
                        ),
                      )
                    : alreadyExists(highScores, score)
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    '''A pontuação $score já foi atingida:
                                ${findScore(highScores, score)} 
                                ''',
                                    style: textMenu,
                                  ),
                                ),
                                ButtonCustom(
                                  textButton: 'Tentar Novamente',
                                  fnc: restartGame,
                                ),
                              ],
                            ),
                          )
                        : Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'A pontuação $score não é um record!',
                                    style: textMenu,
                                  ),
                                ),
                                ButtonCustom(
                                  textButton: 'Tentar Novamente',
                                  fnc: restartGame,
                                ),
                              ],
                            ),
                          )
                : Visibility(
                    visible: matchedCards.length < 40,
                    child: Expanded(
                      child: GridView.builder(
                        itemCount: cards.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: isLandscape(context) ? 10 : 5,
                            crossAxisSpacing: 1,
                            childAspectRatio: .9),
                        itemBuilder: (BuildContext context, int index) {
                          return AnimatedBuilder(
                            animation: _animationController!,
                            builder: (BuildContext context, Widget? child) {
                              return Transform.scale(
                                scale: _cardAnimations[index].value,
                                child: child,
                              );
                            },
                            child: GestureDetector(
                              onTap: () {
                                flipCard(index);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 4,
                                      color: matchedCards.contains(index)
                                          ? primaryColor
                                          : Colors.transparent,
                                    ),
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.all(1),
                                    decoration: BoxDecoration(
                                      color: matchedCards.contains(index)
                                          ? Colors.transparent
                                          : visibleCards.contains(index)
                                              ? Colors.transparent
                                              : primaryColor,
                                    ),
                                    child: Center(
                                      child: flippedCards[index]
                                          ? Image.asset(
                                              kPathImage(cards[index]),
                                            )
                                          : Container(
                                              child: Center(
                                                child: Text(
                                                  '?',
                                                  style: textQuestion,
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }

  isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }
}
