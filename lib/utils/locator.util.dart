import 'package:aphasia_saviour/services/shared_preference.service.dart';
import 'package:aphasia_saviour/services/text_to_speech.service.dart';
import 'package:aphasia_saviour/services/words.service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.instance();

void setupLocator() {
  // locator.registerSingleton(() => WordsService());
  // locator.registerSingleton(() => SharedPreferencesService());
  // locator.registerSingleton(() => FlutterTts());
}