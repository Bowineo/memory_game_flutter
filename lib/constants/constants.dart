String kTitle = 'Jogo da Memória';
String kLogo = 'assets/images/logo.png';
String kTextMenu = 'Vamos jogar!';
String kRecords = 'Melhores Pontuações';
String kScore = 'Pontuação:';
String kSaveName = 'Parabéns sua pontuação foi';

String kThemeGame(int themeGame) {
  switch (themeGame) {
    case 2:
      return 'Animais e Frutas';
    case 1:
      return 'Frutas';
    default:
      return 'Animais';
  }
}

int kGetThemeGame(String themeGame) {
  switch (themeGame) {
    case 'Animais e Frutas':
      return 2;
    case 'Frutas':
      return 1;
    default:
      return 0;
  }
}

String kPathImage(String cardIndex) {
  return 'assets/images/animalsAndFruits/$cardIndex.png';
}

String kThemeFolder(int theme) {
  switch (theme) {
    case 2:
      return 'animalsAndFruits';
    case 1:
      return 'fruits';
    default:
      return 'animals';
  }
}
