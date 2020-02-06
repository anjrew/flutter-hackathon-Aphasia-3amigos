import 'package:aphasia_saviour/models/country_data.model.dart';
import 'package:aphasia_saviour/models/word.model.dart';
import 'package:aphasia_saviour/resources/countrys.values.dart';
import 'package:aphasia_saviour/resources/keys.values.dart';
import 'package:aphasia_saviour/services/shared_preference.service.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:aphasia_saviour/services/words.service.dart';
import 'package:aphasia_saviour/utils/locator.util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class AddTextPage extends StatefulWidget {
  @override
  _AddTextPageState createState() => _AddTextPageState();
}

class _AddTextPageState extends State<AddTextPage> {
  TextEditingController editingController = TextEditingController();
  TextToSpeechService ttsService = serviceLocator.get<TextToSpeechService>();
  WordsService wordService = serviceLocator.get<WordsService>();
  List<Word> savedWords = [];
  List<Word> filteredWords = [];

  @override
  void initState() {
    super.initState();
    asyncInit();
  }

  Future<void> asyncInit() async {
    savedWords = await wordService.getWords() ?? [] ;
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
                itemCount: filteredWords.length,
                itemBuilder: (context, index) => Slidable(
                  key: Key(index.toString()),
                  direction: Axis.horizontal,
                  actionPane: SlidableStrechActionPane(),
                  actionExtentRatio: 0.25,
                  child: ListTile(
                    key: Key(filteredWords[index].toString()),
                    leading: Text(filteredWords[index].country.flagUtf),
                    title: Text(filteredWords[index].text),
                    subtitle: Text(filteredWords[index].catagory),
                    trailing: IconButton(
                        icon: Icon(Icons.surround_sound),
                        onPressed: () {
                          ttsService
                              .setLanguage(filteredWords[index].country.code);
                          ttsService.speak(filteredWords[index].text);
                        }),
                  ),
                  secondaryActions: <Widget>[
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => deleteWord(filteredWords[index]),
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
    dummySearchList.addAll(savedWords);
    print(query);
    if (query != null && query != "") {
      List<Word> dummyListData = List<Word>();
      dummySearchList.forEach((item) {
        if (item.catagory.toLowerCase().contains(query.toLowerCase())) {
          dummyListData.add(item);
        }
      });
      setState(() {
        filteredWords.clear();
        filteredWords.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        filteredWords.clear();
        filteredWords.addAll(savedWords);
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
      savedWords.insert(0, word);
      wordService.saveWord(word);
    filterSearchResults(editingController.text);
  }

  void deleteWord(Word wordToDelete) {
    wordService.deleteWord(wordToDelete);
    setState(() => this
        .savedWords
        .removeWhere((Word word) => word.hashCode == wordToDelete.hashCode));
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
        catagory: _catTextEditingController.text,
        text: _textEditingController.text));
  }
}
