
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:aphasia_saviour/models/country_data.model.dart';

class Word {
  int id;
	CountryData country;
	String catagory;
	String text;
  Word({
    this.id,
    @required this.country,
    @required this.catagory,
    @required this.text,
  });
  

  Word copyWith({
    int id,
    CountryData country,
    String catagory,
    String text,
  }) {
    return Word(
      id: id ?? this.id,
      country: country ?? this.country,
      catagory: catagory ?? this.catagory,
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'country': country.toMap(),
      'catagory': catagory,
      'text': text,
    };
  }

  static Word fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Word(
      id: map['id'],
      country: CountryData.fromMap(map['country']),
      catagory: map['catagory'],
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  static Word fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Word id: $id, country: $country, catagory: $catagory, text: $text';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Word &&
      o.id == id &&
      o.country == country &&
      o.catagory == catagory &&
      o.text == text;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      country.hashCode ^
      catagory.hashCode ^
      text.hashCode;
  }
}
