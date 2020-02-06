import 'package:aphasia_saviour/models/word.model.dart';
import 'package:aphasia_saviour/resources/keys.values.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:aphasia_saviour/services/words.service.dart';
import 'package:aphasia_saviour/utils/locator.util.dart';
import 'package:flutter/material.dart';

class CatagoriesPage extends StatefulWidget {
  @override
  _CatagoriesPageState createState() => _CatagoriesPageState();
}

class _CatagoriesPageState extends State<CatagoriesPage> {
  TextToSpeechService tts = serviceLocator.get<TextToSpeechService>();
  List<Word> values = [];
  WordsService wordsService = serviceLocator.get<WordsService>();

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    tts = TextToSpeechService();
    setState(() async {
      values = await wordsService.getWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
