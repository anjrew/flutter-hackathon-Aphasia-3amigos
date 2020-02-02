import 'package:aphasia_saviour/models/country_data.model.dart';
import 'package:aphasia_saviour/models/word.model.dart';
import 'package:aphasia_saviour/resources/countrys.values.dart';
import 'package:aphasia_saviour/resources/keys.values.dart';
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
  TextEditingController editingController = TextEditingController();
  List<Word> renderList = [];

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
      values = sharedPrefs
          .getStringList(id: AppKeys.wordsKey)
          .map((e) {
            List a = e.split(',');
            if (a.length > 1) {
              return new Word(a[0], a[1], a[2]);
            } else {
              return new Word('', "", a[0]);
            }
          })
          .toList()
          .reversed
          .toList();
    });
    filterSearchResults('');
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                onChanged: filterSearchResults,
                controller: editingController,
                decoration: InputDecoration(
                    labelText: "Search",
                    hintText: "Search for a catagory",
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(25.0)))),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) => Divider(
                  color: Colors.black,
                ),
                itemCount: renderList.length,
                itemBuilder: (context, index) => Slidable(
                  key: Key(index.toString()),
                  direction: Axis.horizontal,
                  actionPane: SlidableStrechActionPane(),
                  actionExtentRatio: 0.25,
                  child: ListTile(
                    key: Key(renderList[index].toString()),
                    leading: Text(renderList[index].country.flagUtf),
                    title: Text(renderList[index].text),
                    subtitle: Text(renderList[index].cat),
                    trailing: IconButton(
                        icon: Icon(Icons.surround_sound),
                        onPressed: () {
                          tts.setLanguage(renderList[index].country.code);
                          tts.speak(renderList[index].text);
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

  void filterSearchResults(String query) {
    List<Word> dummySearchList = List<Word>();
    dummySearchList.addAll(values);
    print(query);
    if (query != null && query != "") {
      List<Word> dummyListData = List<Word>();
      dummySearchList.forEach((item) {
        if (item.cat.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        renderList.clear();
        renderList.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        renderList.clear();
        renderList.addAll(values);
      });
    }
  }

  void addTextDiolog() async {
    var value = await showDialog(
      context: context,
      builder: (diologContext) {
        return AddWordDiolog();
      },
    );


    if (value is Word) {
      addTextToList(value);
    }
  }

  void addTextToList(Word word) async {
    this.values.insert(0, word);
    setState(() {
      sharedPrefs.setStringList(
        id: AppKeys.wordsKey,
        strings: this
            .values
            .map(
              (e) {
                return "${e.country},${e.cat},${e.text}";
              },
            )
            .toList()
            .reversed
            .toList(),
      );
    });
    filterSearchResults(editingController.text);
  }

  void deleteWord(int index) {
    this.values.removeAt(index);
    setState(() {
      sharedPrefs.setStringList(
        id: AppKeys.wordsKey,
        strings: this.values.map(
          (e) {
            return "${e.country},${e.cat},${e.text}";
          },
        ).toList(),
      );
    });
    filterSearchResults(editingController.text);
  }
}


class AddWordDiolog extends StatefulWidget {
  @override
  _AddWordDiologState createState() => _AddWordDiologState();
}

class _AddWordDiologState extends State<AddWordDiolog> {
  TextEditingController _textEditingController;
  TextEditingController _catTextEditingController;
  CountryData country;
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
        new DropdownButton<CountryData>(
          hint: Text("Language"),
          value: country ?? english,
          items: countrys.map((CountryData value) {
            return new DropdownMenuItem<CountryData>(
              value: value,
              child: new Text(value.flagUtf),
            );
          }).toList(),
          onChanged: (v) {
            setState(() {
              this.country = v;
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
    Navigator.of(context).pop(new Word(
        country: country,
        cat: _catTextEditingController.text,
        text: _textEditingController.text));
  }
}
