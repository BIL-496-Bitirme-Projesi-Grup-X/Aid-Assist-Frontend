// To parse this JSON data, do
//
//     final Earthquakes = EarthquakesFromJson(jsonString);

import 'dart:convert';

// ignore: non_constant_identifier_names
Earthquakes EarthquakesFromJson(String str) =>
    Earthquakes.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String EarthquakesToJson(Earthquakes data) => json.encode(data.toJson());

class Earthquakes {
  Earthquakes({
    this.status,
    this.result,
  });

  bool status;
  List<Result> result;

  factory Earthquakes.fromJson(Map<String, dynamic> json) => Earthquakes(
        status: json["status"],
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.mag,
    this.lng,
    this.lat,
    this.lokasyon,
    this.depth,
    this.coordinates,
    this.title,
    this.rev,
    this.timestamp,
    this.dateStamp,
    this.date,
    this.hash,
    this.hash2,
  });

  double mag;
  double lng;
  double lat;
  String lokasyon;
  double depth;
  List<double> coordinates;
  String title;
  dynamic rev;
  int timestamp;
  DateTime dateStamp;
  String date;
  String hash;
  String hash2;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        mag: json["mag"].toDouble(),
        lng: json["lng"].toDouble(),
        lat: json["lat"].toDouble(),
        lokasyon: json["lokasyon"],
        depth: json["depth"].toDouble(),
        coordinates:
            List<double>.from(json["coordinates"].map((x) => x.toDouble())),
        title: json["title"],
        rev: json["rev"],
        timestamp: json["timestamp"],
        dateStamp: DateTime.parse(json["date_stamp"]),
        date: json["date"],
        hash: json["hash"],
        hash2: json["hash2"],
      );

  Map<String, dynamic> toJson() => {
        "mag": mag,
        "lng": lng,
        "lat": lat,
        "lokasyon": lokasyon,
        "depth": depth,
        "coordinates": List<dynamic>.from(coordinates.map((x) => x)),
        "title": title,
        "rev": rev,
        "timestamp": timestamp,
        "date_stamp":
            "${dateStamp.year.toString().padLeft(4, '0')}-${dateStamp.month.toString().padLeft(2, '0')}-${dateStamp.day.toString().padLeft(2, '0')}",
        "date": date,
        "hash": hash,
        "hash2": hash2,
      };
}
