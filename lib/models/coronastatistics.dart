import 'dart:convert';

// ignore: non_constant_identifier_names
DailyCoronaStatistics DailyCoronaStatisticsFromJson(String str) =>
    DailyCoronaStatistics.fromJson(json.decode(str));

// ignore: non_constant_identifier_names
String DailyCoronaStatisticsToJson(DailyCoronaStatistics data) =>
    json.encode(data.toJson());

class DailyCoronaStatistics {
  DailyCoronaStatistics({
    this.infected,
    this.deceased,
    this.recovered,
    this.tested,
    this.critical,
    this.icu,
    this.dailyTested,
    this.dailyInfected,
    this.dailyDeceased,
    this.dailyRecovered,
    this.sourceUrl,
    this.lastUpdatedAtApify,
    this.lastUpdatedAtSource,
    this.readMe,
  });

  int infected;
  int deceased;
  int recovered;
  int tested;
  int critical;
  int icu;
  int dailyTested;
  int dailyInfected;
  int dailyDeceased;
  int dailyRecovered;
  String sourceUrl;
  DateTime lastUpdatedAtApify;
  DateTime lastUpdatedAtSource;
  String readMe;

  factory DailyCoronaStatistics.fromJson(Map<String, dynamic> json) =>
      DailyCoronaStatistics(
        infected: json["infected"],
        deceased: json["deceased"],
        recovered: json["recovered"],
        tested: json["tested"],
        critical: json["critical"],
        icu: json["ICU"],
        dailyTested: json["dailyTested"],
        dailyInfected: json["dailyInfected"],
        dailyDeceased: json["dailyDeceased"],
        dailyRecovered: json["dailyRecovered"],
        sourceUrl: json["sourceUrl"],
        lastUpdatedAtApify: DateTime.parse(json["lastUpdatedAtApify"]),
        lastUpdatedAtSource: DateTime.parse(json["lastUpdatedAtSource"]),
        readMe: json["readMe"],
      );

  Map<String, dynamic> toJson() => {
        "infected": infected,
        "deceased": deceased,
        "recovered": recovered,
        "tested": tested,
        "critical": critical,
        "ICU": icu,
        "dailyTested": dailyTested,
        "dailyInfected": dailyInfected,
        "dailyDeceased": dailyDeceased,
        "dailyRecovered": dailyRecovered,
        "sourceUrl": sourceUrl,
        "lastUpdatedAtApify": lastUpdatedAtApify.toIso8601String(),
        "lastUpdatedAtSource": lastUpdatedAtSource.toIso8601String(),
        "readMe": readMe,
      };
}
