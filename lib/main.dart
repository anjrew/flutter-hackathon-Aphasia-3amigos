import 'package:aphasia_saviour/services/BottomButton.dart';
import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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
  var language = ["🇬🇧", "🇵🇱", "🇩🇪"];
  var languageCode = ["en-US", "pl", "de"];
  var currentLanguage = 0;

  void changeLanguage() {
    setState(() {
      currentLanguage++;
      if (currentLanguage == language.length) {
        currentLanguage = 0;
      }
    });
    print("Main: " + languageCode[currentLanguage]);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
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
          )
        ],
      ),
      body: WordGame(languageCode[currentLanguage]),
    );
  }
}
