import 'package:aphasia_saviour/services/shared_preference.service.dart';
import 'package:aphasia_saviour/services/words.service.dart';
import 'package:get_it/get_it.dart';

GetIt locator = GetIt.asNewInstance();

void setupLocator() {
  locator.registerLazySingleton(() => SharedPreferencesService());
  locator.registerLazySingleton(() => WordsService());
}