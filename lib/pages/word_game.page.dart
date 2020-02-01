import 'dart:math';
import 'package:aphasia_saviour/services/BottomButton.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:flutter/material.dart';

class WordGame extends StatefulWidget {
  var languageCode;

  WordGame(languageCode);

  @override
  _WordGameState createState() => _WordGameState(languageCode);
}

class _WordGameState extends State<WordGame> {
  var languageCode;
  _WordGameState(this.languageCode);

  String _selectedWord = "";
  List<String> _array = [
    "Hallo",
    "Computer",
    "Cat",
    "Dog",
    "Tiger",
    "Phone",
    "House"
  ];
  var rnd = new Random();
  var count = 0;
  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    tts.setLanguage("de-DE");
    tts.setSpeechRate(0.1);
    super.initState();
    _start();
  }


  void _start() {
    setState(() {
      _selectedWord = _array[count];
    });
  }

  void _nextWord() {
    setState(() {
      count++;
      if (count >= _array.length) count = _array.length - 1;
      _selectedWord = _array[count];
    });
  }

  void _previousWord() {
    setState(() {
      count--;
      if (count < 0) count = 0;
      _selectedWord = _array[count];
    });
  }

  void _playSound() {
    tts.speak(_selectedWord);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                '$_selectedWord',
                style: Theme.of(context).textTheme.headline4,
              ),
            ],
          ),
        ),
        BottomButton(
          alignment: Alignment.bottomLeft,
          icon: Icons.navigate_before,
          tooltip: "Back",
          onButtonPressed: () {
            _previousWord();
          },
        ),
        BottomButton(
          alignment: Alignment.bottomCenter,
          icon: Icons.play_arrow,
          tooltip: "Hear Sound",
          onButtonPressed: () {
            _playSound();
          },
        ),
        BottomButton(
          alignment: Alignment.bottomRight,
          icon: Icons.navigate_next,
          tooltip: "Next",
          onButtonPressed: () {
            _nextWord();
          },
        ),
      ],
    );
  }
}
