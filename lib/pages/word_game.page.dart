import 'dart:math';
import 'package:aphasia_saviour/services/BottomButton.dart';
import 'package:flutter/material.dart';

class WordGame extends StatefulWidget {

  @override
  _WordGameState createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {


  String _selectedWord = "";
  List<String> _array = ["1", "2", "3", "4", "5"];
  var rnd = new Random();
  var count = 0;

   @override
  void initState() {
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
