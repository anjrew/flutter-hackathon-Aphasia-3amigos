import 'dart:math';
import 'package:aphasia_saviour/services/BottomButton.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:flutter/material.dart';

class WordGame extends StatefulWidget {
  String languageCode;

  WordGame(String languageCode) : this.languageCode = languageCode;

  @override
  _WordGameState createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  String _selectedWord = "";

  Map _words = {
    "en-US": ["Cat", "Dog", "Tiger", "Phone", "House"],
    "pl-PL": ["Kot", "Pies", "Tygrys", "Telefon", "Dom"],
    "de-DE": ["Katze", "Hund", "Tiger", "Handy", "Haus"]
  };
  var rnd = new Random();
  var count = 0;
  FlutterTts tts = FlutterTts();

  @override
  void initState() {
    tts.setLanguage(widget.languageCode);
    tts.setSpeechRate(0.1);
    super.initState();
    _start();
  }

  @override
  void didUpdateWidget(WordGame oldWidget) {
    // TODO: implement didUpdateWidget
    tts.setLanguage(widget.languageCode);
    _selectedWord = _words[widget.languageCode][count];
    super.didUpdateWidget(oldWidget);
  }

  void _start() {
    setState(() {
      _selectedWord = _words[widget.languageCode][count];
    });
  }

  void _nextWord() {
    setState(() {
      count++;
      var len = _words[widget.languageCode].length;
      if (count >= len) count = len - 1;
      _selectedWord = _words[widget.languageCode][count];
    });
  }

  void _previousWord() {
    setState(() {
      count--;
      if (count < 0) count = 0;
      _selectedWord = _words[widget.languageCode][count];
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
