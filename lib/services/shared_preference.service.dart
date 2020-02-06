// import 'package:flutter/foundation.dart';
// import 'package:shared_preferences/shared_preferences.dart';

// class SharedPreferencesService {


//   SharedPreferences prefs;

//   SharedPreferencesService(){
//     initService();
//   }

//   Future<bool> initService() async {
//     prefs = await SharedPreferences.getInstance(); 
//     return true;
//   }

//   void setString({@required String id, @required  String string}){
//     prefs.setString(id, string);
//   }

//   String getString({@required String id}){
//     return prefs.getString(id);
//   }

//   List<String> getStringList({@required String id}){
//     return prefs.getStringList(id);
//   }

//   void setStringList({@required String id, @required  List<String> strings}){
//     prefs.setStringList(id, strings);
//   }

// }