import 'package:aphasia_saviour/resources/keys.dart';
import 'package:aphasia_saviour/services/shared_preference.service.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddTextPage extends StatefulWidget {
  @override
  _AddTextPageState createState() => _AddTextPageState();
}

class _AddTextPageState extends State<AddTextPage> {
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
    return Stack(children: [
      ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: values.length,
        itemBuilder: (context, index) => Slidable(
          key: Key(index.toString()),
          direction: Axis.horizontal,
          actionPane: SlidableStrechActionPane(),
          actionExtentRatio: 0.25,
          child: ListTile(
              key: Key(values[index].toString()),
              title: Text(values[index]),
              trailing: IconButton(
                  icon: Icon(Icons.surround_sound),
                  onPressed: () => tts.speak(values[index])),
          ),
          secondaryActions: <Widget>[
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => deleteWord(index),
            ),
          ],
        ),
      ),
      Positioned(
        bottom: 20,
        right: 20,
        child: FloatingActionButton(
            child: Icon(Icons.add), onPressed: () => addTextDiolog()),
      ),
    ]);
  }

  void addTextDiolog() async {
    var value = await showDialog(
      context: context,
      builder: (diologContext) {
        return AddWordDiolog();
      },
    );

    print(value);

    if (value is String) {
      addTextToList(value);
    }
  }

  void addTextToList(String word) async {
    this.values.add(word);
    setState(() {
      sharedPrefs.setStringList(id: AppKeys.wordsKey, strings: this.values);
    });
  }

  void deleteWord(int index) {
    this.values.removeAt(index);
    setState(() {
      sharedPrefs.setStringList(id: AppKeys.wordsKey, strings: this.values);
    });
  }
}

class AddWordDiolog extends StatefulWidget {
  @override
  _AddWordDiologState createState() => _AddWordDiologState();
}

class _AddWordDiologState extends State<AddWordDiolog> {
  TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      title: Text("Add word"),
      contentPadding: EdgeInsets.all(20),
      children: <Widget>[
        TextFormField(
          controller: _textEditingController,
        ),
        RaisedButton(
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          child: Text("Add"),
          onPressed: addWord,
        ),
      ],
    );
  }

  void addWord() {
    Navigator.of(context).pop(_textEditingController.text);
  }
}
