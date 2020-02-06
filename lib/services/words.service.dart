import 'package:aphasia_saviour/models/word.model.dart';
import 'package:aphasia_saviour/services/storage.service.dart';
import 'package:aphasia_saviour/utils/locator.util.dart';

class WordsService {

	StorageService storageService = serviceLocator.get<StorageService>();

	Future<void> deleteWord(Word word) async {
		this.storageService.delete();
	}

	Future<List<Word>> getWords() async {
		
	}

  Future<void> saveWord(Word word) async {

	}
}