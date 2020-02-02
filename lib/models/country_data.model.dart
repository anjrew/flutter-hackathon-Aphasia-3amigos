import 'dart:convert';

import 'package:flutter/foundation.dart';

class CountryData {
  String name;
	String code;
	String flagUtf;
  CountryData({
    @required this.name,
    @required this.code,
    @required this.flagUtf,
  });
	

  CountryData copyWith({
    String name,
    String code,
    String uft,
  }) {
    return CountryData(
      name: name ?? this.name,
      code: code ?? this.code,
      flagUtf: uft ?? this.flagUtf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'uft': flagUtf,
    };
  }

  static CountryData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return CountryData(
      name: map['name'],
      code: map['code'],
      flagUtf: map['uft'],
    );
  }

  String toJson() => json.encode(toMap());

  static CountryData fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() => 'CountryData name: $name, code: $code, uft: $flagUtf';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is CountryData &&
      o.name == name &&
      o.code == code &&
      o.flagUtf == flagUtf;
  }

  @override
  int get hashCode => name.hashCode ^ code.hashCode ^ flagUtf.hashCode;
}
