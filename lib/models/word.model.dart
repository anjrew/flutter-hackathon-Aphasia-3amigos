
import 'dart:convert';
import 'package:aphasia_saviour/models/country_data.model.dart';
import 'package:flutter/foundation.dart';


class Word {
	CountryData country;
	String cat;
	String text;
  Word({
    @required this.country,
    @required this.cat,
    @required this.text,
  });


  Word copyWith({
    CountryData country,
    String cat,
    String text,
  }) {
    return Word(
      country: country ?? this.country,
      cat: cat ?? this.cat,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'country': country.toMap(),
      'cat': cat,
      'text': text,
    };
  }

  static Word fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Word(
      country: CountryData.fromMap(map['country']),
      cat: map['cat'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  static Word fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'Word country: $country, cat: $cat, text: $text';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Word &&
      o.country == country &&
      o.cat == cat &&
      o.text == text;
  }

  @override
  int get hashCode => country.hashCode ^ cat.hashCode ^ text.hashCode;
}
