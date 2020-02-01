import 'package:aphasia_saviour/models/word.model.dart';
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
  List<Word> values = [];

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
      values = sharedPrefs.getStringList(id: AppKeys.wordsKey).map((e) {
        List a = e.split(',');
        if (a.length > 1) {
          
        return new Word(a[0], a[1], a[2]);
        } else {
          return new Word('' ,"", a[0]);
        }
      }).toList();
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
            leading: Text( values[index].lang == 'en-Us' ? "🇬🇧" : values[index].lang == "pl-PL" ? "🇵🇱" : "🇩🇪"),
            title: Text(values[index].text),
            subtitle: Text(values[index].cat),
            trailing: IconButton(
                icon: Icon(Icons.surround_sound),
                onPressed: () {
                  tts.setLanguage(values[index].lang);
                  tts.speak(values[index].text);
                  }),
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

    if (value is Word) {
      addTextToList(value);
    }
  }

  void addTextToList(Word word) async {
    this.values.add(word);
    setState(() {
      sharedPrefs.setStringList(
        id: AppKeys.wordsKey,
        strings: this.values.map(
          (e) {
            return "${e.lang},${e.cat},${e.text}";
          },
        ).toList(),
      );
    });
  }

  void deleteWord(int index) {
    this.values.removeAt(index);
    setState(() {
      sharedPrefs.setStringList(
        id: AppKeys.wordsKey,
        strings: this.values.map(
          (e) {
            return "${e.lang},${e.cat},${e.text}";
          },
        ).toList(),
      );
    });
  }
}

class AddWordDiolog extends StatefulWidget {
  @override
  _AddWordDiologState createState() => _AddWordDiologState();
}

class _AddWordDiologState extends State<AddWordDiolog> {
  TextEditingController _textEditingController;
  TextEditingController _catTextEditingController;
  String lang = 'pl-PL';
  String cat = '';

  @override
  void initState() {
    super.initState();
    _textEditingController = new TextEditingController();
    _catTextEditingController = new TextEditingController();
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
          decoration: InputDecoration(labelText: "Text"),
          controller: _textEditingController,
        ),
        TextFormField(
          decoration: InputDecoration(labelText: "Catagory"),
          controller: _catTextEditingController,
        ),
        new DropdownButton<String>(
          hint: Text("Language"),
          value: lang,
          items: <String>['en-Us', 'DE', 'pl-PL'].map((String value) {
            return new DropdownMenuItem<String>(
              value: value,
              child: new Text(value),
            );
          }).toList(),
          onChanged: (v) {
            setState(() {
              this.lang = v;
            });
          },
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
    Navigator.of(context)
        .pop(new Word(lang, _catTextEditingController.text ,_textEditingController.text));
  }
}
