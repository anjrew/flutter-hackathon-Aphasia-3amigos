import 'package:aphasia_saviour/services/database.service.dart';
import 'package:aphasia_saviour/services/storage.service.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:aphasia_saviour/services/words.service.dart';
import 'package:get_it/get_it.dart';

GetIt serviceLocator = GetIt.instance;

void setupLocator() {
  serviceLocator.registerLazySingleton(() => TextToSpeechService());
  serviceLocator.registerLazySingleton(() => DatabaseService());
  serviceLocator.registerLazySingleton(() => StorageService());
  serviceLocator.registerLazySingleton(() => WordsService());
  // locator.registerSingleton(() => SharedPreferencesService());
}