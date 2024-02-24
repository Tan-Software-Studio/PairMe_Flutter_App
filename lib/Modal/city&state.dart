// To parse this JSON data, do
//
//     final cityandState = cityandStateFromJson(jsonString);

import 'dart:convert';

CityandState cityandStateFromJson(String str) => CityandState.fromJson(json.decode(str));

String cityandStateToJson(CityandState data) => json.encode(data.toJson());

class CityandState {
  bool? status;
  int? code;
  City? city;
  CityandStateState? state;

  CityandState({
     this.status,
     this.code,
     this.city,
     this.state,
  });

  factory CityandState.fromJson(Map<String, dynamic> json) => CityandState(
    status: json["status"],
    code: json["code"],
    city: City.fromJson(json["city"]),
    state: CityandStateState.fromJson(json["state"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "code": code,
    "city": city?.toJson(),
    "state": state?.toJson(),
  };
}

class City {
  String id;
  String iso2;
  String iso3;
  String country;
  List<String> cities;
  int v;

  City({
    required this.id,
    required this.iso2,
    required this.iso3,
    required this.country,
    required this.cities,
    required this.v,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["_id"],
    iso2: json["iso2"],
    iso3: json["iso3"],
    country: json["country"],
    cities: List<String>.from(json["cities"].map((x) => x)),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "iso2": iso2,
    "iso3": iso3,
    "country": country,
    "cities": List<dynamic>.from(cities.map((x) => x)),
    "__v": v,
  };
}

class CityandStateState {
  String id;
  String name;
  String iso3;
  String iso2;
  List states;
  int v;

  CityandStateState({
    required this.id,
    required this.name,
    required this.iso3,
    required this.iso2,
    required this.states,
    required this.v,
  });

  factory CityandStateState.fromJson(Map<String, dynamic> json) => CityandStateState(
    id: json["_id"],
    name: json["name"],
    iso3: json["iso3"],
    iso2: json["iso2"],
    states: List.from(json["states"].map((x) => StateElement.fromJson(x))),
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "name": name,
    "iso3": iso3,
    "iso2": iso2,
    "states": List.from(states.map((x) => x.toJson())),
    "__v": v,
  };
}

class StateElement {
  String name;
  String stateCode;

  StateElement({
    required this.name,
    required this.stateCode,
  });

  factory StateElement.fromJson(Map<String, dynamic> json) => StateElement(
    name: json["name"],
    stateCode: json["state_code"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "state_code": stateCode,
  };
}
