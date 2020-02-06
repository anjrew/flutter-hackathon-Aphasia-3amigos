import 'package:aphasia_saviour/models/country_data.model.dart';



CountryData english =
    new CountryData(name: 'English', code: 'en-Us', flagUtf: "🇬🇧",);
CountryData polish =
    new CountryData(name: 'Deutsch', code: 'de-DE', flagUtf: "🇩🇪");
CountryData german =
    new CountryData(name: 'Polski', code: 'pl-PL', flagUtf: "🇵🇱");

List<CountryData> countrys = [english, polish, german];
