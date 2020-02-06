import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';

class CountryData {
  String name;
  String code;
  String flagUtf;
  int id;
  CountryData({
    @required this.name,
    @required this.code,
    @required this.flagUtf,
    this.id,
  }) {
    if (this.id == null) {
      this.id = Random().nextInt(3);
    }
  }

  CountryData copyWith({
    String name,
    String code,
    String flagUtf,
    int id,
  }) {
    return CountryData(
      name: name ?? this.name,
      code: code ?? this.code,
      flagUtf: flagUtf ?? this.flagUtf,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'code': code,
      'flagUtf': flagUtf,
      'id': id,
    };
  }

  static CountryData fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CountryData(
      name: map['name'],
      code: map['code'],
      flagUtf: map['flagUtf'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static CountryData fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'CountryData name: $name, code: $code, flagUtf: $flagUtf, id: $id';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CountryData &&
        o.name == name &&
        o.code == code &&
        o.flagUtf == flagUtf &&
        o.id == id;
  }

  @override
  int get hashCode {
    return name.hashCode ^ code.hashCode ^ flagUtf.hashCode ^ id.hashCode;
  }
}
