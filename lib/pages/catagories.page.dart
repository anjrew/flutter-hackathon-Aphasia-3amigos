import 'package:aphasia_saviour/resources/keys.dart';
import 'package:aphasia_saviour/services/shared_preference.service.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:flutter/material.dart';

class CatagoriesPage extends StatefulWidget {
	@override
	_CatagoriesPageState createState() => _CatagoriesPageState();
}

class _CatagoriesPageState extends State<CatagoriesPage> {

	FlutterTts tts;
  SharedPreferencesService sharedPrefs;
  List<String> values = [];

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    tts = FlutterTts();
    sharedPrefs = SharedPreferencesService();
    await sharedPrefs.initService();
    setState(() {
      values = sharedPrefs.getStringList(id: AppKeys.wordsKey);
    });
  }


	@override
	Widget build(BuildContext context) {
		return Container(
			
		);
	}
}