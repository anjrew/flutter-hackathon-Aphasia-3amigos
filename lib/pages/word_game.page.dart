import 'dart:math';
import 'package:aphasia_saviour/models/country_data.model.dart';
import 'package:aphasia_saviour/resources/countrys.values.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:aphasia_saviour/utils/locator.util.dart';
import 'package:aphasia_saviour/widgets/bottom_button.widget.dart';
import 'package:flutter/material.dart';

class WordGame extends StatefulWidget {
  @override
  _WordGameState createState() => _WordGameState();
}

class _WordGameState extends State<WordGame> {
  TextToSpeechService tts = serviceLocator.get<TextToSpeechService>();

  String _selectedWord = "";
  CountryData _dropDownValue = countrys[0];
  List images = ["cat.jpeg", "dog.jpg", "tiger.jpg", "phone.jpg", "house.jpg"];
  Map _words = {
    "en-US": ["Cat", "Dog", "Tiger", "Phone", "House"],
    "pl-PL": ["Kot", "Pies", "Tygrys", "Telefon", "Dom"],
    "de-DE": ["Katze", "Hund", "Tiger", "Handy", "Haus"]
  };
  var rnd = new Random();
  var count = 0;

  String languageCode;

  @override
  void initState() {
    super.initState();
    languageCode ??= "en-US";
    tts.setLanguage(languageCode);
    tts.setSpeechRate(0.2);
    _start();
  }

  void _start() {
    setState(() {
      _selectedWord = _words[languageCode][count];
    });
  }

  void _nextWord() {
    setState(() {
      count++;
      var len = _words[languageCode].length;
      if (count >= len) count = len - 1;
      _selectedWord = _words[languageCode][count];
    });
  }

  void _previousWord() {
    setState(() {
      count--;
      if (count < 0) count = 0;
      _selectedWord = _words[languageCode][count];
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                DropdownButton<CountryData>(
                  value: _dropDownValue,
                  onChanged: (CountryData newValue) {
                    setState(() {
                      _dropDownValue = newValue;
                    });
                  },
                  items: countrys.map<DropdownMenuItem<CountryData>>(
                      (CountryData country) {
                    return DropdownMenuItem<CountryData>(
                      value: country,
                      child: Text(country.flagUtf ?? 'ERROR',
                          style: TextStyle(fontSize: 25.0),
                          textAlign: TextAlign.center),
                    );
                  }).toList(),
                ),
                Image.asset(
                  'assets/images/' + images[count],
                  height: MediaQuery.of(context).size.height * 0.40,
                ),
                Text(
                  _selectedWord ?? 'ERROR',
                  style: Theme.of(context).textTheme.headline4,
                ),
              ],
            ),
          ),
        ),
        BottomButton(
          alignment: Alignment.bottomLeft,
          icon: Icons.navigate_before,
          tooltip: "Back",
          onButtonPressed: _previousWord,
        ),
        BottomButton(
          alignment: Alignment.bottomCenter,
          icon: Icons.play_arrow,
          tooltip: "Hear Sound",
          onButtonPressed: _playSound,
        ),
        BottomButton(
          alignment: Alignment.bottomRight,
          icon: Icons.navigate_next,
          tooltip: "Next",
          onButtonPressed: _nextWord,
        ),
      ],
    );
  }
}
