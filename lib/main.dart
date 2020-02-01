import 'package:aphasia_saviour/pages/add_text.dart';
import 'package:aphasia_saviour/pages/word_game.page.dart';
import 'package:aphasia_saviour/utils/locator.util.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
        title: 'Main Page UI',
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;
  var language = ["🇬🇧", "🇵🇱", "🇩🇪"];
  var languageCode = ["en-US", "pl-PL", "de-DE"];
  var currentLanguage = 0;
  List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      WordGame(languageCode[currentLanguage]),
      AddTextPage()
    ];
  }

  void changeLanguage() {
    setState(() {
      currentLanguage++;
      if (currentLanguage == language.length) {
        currentLanguage = 0;
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: <Widget>[
            new InkWell(
              onTap: () {
                changeLanguage();
              },
              child: new Padding(
                padding: new EdgeInsets.all(8.0),
                child: new Text(
                  language[currentLanguage],
                  style: new TextStyle(
                    fontSize: 35.0,
                  ),
                ),
              ),
            ),
          ],
        ),
        body: <Widget>[WordGame(languageCode[currentLanguage]), AddTextPage()]
            .elementAt(_selectedIndex),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.gamepad),
              title: Text('Game'),
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text('Search'),
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Theme.of(context).primaryColor,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
