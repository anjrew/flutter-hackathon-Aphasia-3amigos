import 'package:aphasia_saviour/pages/home.page.dart';
import 'package:aphasia_saviour/utils/locator.util.dart';
import 'package:flutter/material.dart';

void main() {
  setupLocator();
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Aphasia',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}
