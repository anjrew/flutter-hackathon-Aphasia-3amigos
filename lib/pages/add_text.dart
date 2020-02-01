import 'package:flutter/material.dart';

class AddTextPage extends StatefulWidget {
  @override
  _AddTextPageState createState() => _AddTextPageState();
}

class _AddTextPageState extends State<AddTextPage> {
  List<String> values = ["Yo", "Hello"];

  TextEditingController _textEditingController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      ListView.separated(
        separatorBuilder: (context, index) => Divider(
          color: Colors.black,
        ),
        itemCount: values.length,
        itemBuilder: (context, index) => ListTile(
          key: Key(values[index].toString()),
          title: Text(values[index]),
        ),
      ),
      Positioned(
        bottom: 20,
        left: 20,
        child: FloatingActionButton(
					child: Icon(Icons.add),
					onPressed: () => addTextDiolog()),
      ),
    ]);
  }

  void addTextDiolog() async {
    print("Herer");
    await showDialog(context:context,builder:(diologContext) {
        return SimpleDialog(
          title: Text("Add word"),
					contentPadding: EdgeInsets.all(20),
          children: <Widget>[
            TextField(),
            RaisedButton(
							child: Text("Add"),
							onPressed: () => Navigator.of(context).pop("Test"))
          ],
        );
      },);
  }


	void addTextToList(){
		
	}
}
