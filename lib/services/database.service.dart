import 'package:aphasia_saviour/models/word.model.dart';
import 'package:aphasia_saviour/resources/keys.values.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  Database db;
  String dbName = "aphasia_saviour";
  int versionNum = 1;

  DatabaseService() {
    asyncInit();
  }

  void asyncInit() async {
    // Get a location using getDatabasesPath
    String databasesPath = await getDatabasesPath();
    String path = "${databasesPath}aphasia_saviour";

    // Delete the database
    await deleteDatabase(path);

    // open the database
    Database database = await openDatabase(path, version: versionNum,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE ${AppKeys.wordsKey} (${AppKeys.id} INTEGER PRIMARY KEY, ${AppKeys.text} TEXT, ${AppKeys.country} TEXT, ${AppKeys.catagory} TEXT');
    });
  }

  Future<Word> insert(Word word) async {
    word.id = await db.insert(AppKeys.wordsKey, word.toMap());
    return word;
  }

	  

  Future<List<Word>> getWords(int id) async {
    List<Map> results = await db.query(AppKeys.wordsKey);
    if (results.length > 0) {
      return results.map((result) => Word.fromMap(result));
    }
    return null;
  }

  Future<int> deleteById(String table, String columnId, int id) async {
    return await db.delete(AppKeys.wordsKey, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> updateById(String table, String columnId, Map map) async {
    return await db.update(table, map,
        where: '$columnId = ?', whereArgs: [map['id']]);
  }


}
