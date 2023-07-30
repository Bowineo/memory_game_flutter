import 'dart:io';
import 'dart:math';
import 'package:intl/intl.dart';

List<String> orderList(List<String> list) {
  list.sort((a, b) {
    int scoreA = int.parse(a.split(' - ')[1].split(' ')[0]);
    int scoreB = int.parse(b.split(' - ')[1].split(' ')[0]);
    return scoreB.compareTo(scoreA);
  });

  return list.length >= 10 ? list.sublist(0, 10) : list;
}

bool shouldAddScore(List<String> highScores, int score) {
  if (highScores.any(
      (entry) => int.parse(entry.split(' - ')[1].split(' ')[0]) == score)) {
    return false;
  }
  if (highScores.length >= 10) {
    int lowestScoreValue =
        int.parse(highScores.last.split(' - ')[1].split(' ')[0]);
    if (score <= lowestScoreValue) {
      return false;
    }
  }
  return true;
}

bool alreadyExists(List<String> highScores, int score) {
  if (highScores.any(
      (entry) => int.parse(entry.split(' - ')[1].split(' ')[0]) == score)) {
    return true;
  }
  return false;
}

String findScore(List<String> highScores, int score) {
  String foundScore = highScores.firstWhere(
    (entry) => int.parse(entry.split(' - ')[1].split(' ')[0]) == score,
    orElse: () => '',
  );
  return foundScore;
}

List<String> addScore(List<String> highScores, String score) {
  int newScoreValue = int.parse(score.split(' - ')[1].split(' ')[0]);
  if (highScores.any((entry) =>
      int.parse(entry.split(' - ')[1].split(' ')[0]) == newScoreValue)) {
    return highScores;
  }
  highScores.add(score);
  highScores.sort((a, b) {
    int scoreA = int.parse(a.split(' - ')[1].split(' ')[0]);
    int scoreB = int.parse(b.split(' - ')[1].split(' ')[0]);
    return scoreB.compareTo(scoreA);
  });
  if (highScores.length > 10) {
    highScores.removeLast();
  }
  return highScores;
}

List<String> getElementsRandom(List<String> listaEntrada) {
  if (listaEntrada.length <= 10) {
    var rng = Random();
    listaEntrada.shuffle(rng);
    return listaEntrada;
  } else {
    var rng = Random();
    var copiaListaEntrada = List<String>.from(listaEntrada);
    var elementosAleatorios = <String>[];
    for (var i = 0; i < 10; i++) {
      if (copiaListaEntrada.isEmpty) break;
      var indiceAleatorio = rng.nextInt(copiaListaEntrada.length);
      elementosAleatorios.add(copiaListaEntrada[indiceAleatorio]);
      copiaListaEntrada.removeAt(indiceAleatorio);
    }
    return elementosAleatorios;
  }
}

void exitApp() => exit(0);

String dataNow() {
  var now = DateTime.now();
  var formatter = DateFormat('dd/MM/yyyy HH:mm:ss');
  return formatter.format(now);
}
