import 'package:aid_assist/models/coronastatistics.dart';
import 'package:aid_assist/ui/constants.dart';
import 'package:aid_assist/ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DailyCoronaStatisticsScreen extends StatefulWidget {
  @override
  _DailyCoronaStatisticsScreenState createState() =>
      _DailyCoronaStatisticsScreenState();
}

class _DailyCoronaStatisticsScreenState
    extends State<DailyCoronaStatisticsScreen> {
  Future<DailyCoronaStatistics> fetchDailyCoronaStatistics() async {
    final response = await http.get(Uri.https('api.apify.com',
        'v2/key-value-stores/28ljlt47S5XEd1qIi/records/LATEST'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return DailyCoronaStatisticsFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load daily corona statistics');
    }
  }

  Future<DailyCoronaStatistics> futureDailyCoronaStatistics;
  TextStyle textStyle = new TextStyle(fontSize: textSizeSmall);
  var numberFormat = new NumberFormat('###,###,###');

  @override
  void initState() {
    futureDailyCoronaStatistics = fetchDailyCoronaStatistics();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Günlük Korona İstatistikleri")),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(right: 2),
            child: FutureBuilder<DailyCoronaStatistics>(
              future: futureDailyCoronaStatistics,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Container(
                    child: Column(children: <Widget>[
                      newCoronaStatisticsCard(
                          "TEST SAYISI", snapshot.data.dailyTested),
                      newCoronaStatisticsCard(
                          "VAKA SAYISI", snapshot.data.dailyInfected),
                      newCoronaStatisticsCard(
                          "VEFAT SAYISI", snapshot.data.dailyDeceased),
                      newCoronaStatisticsCard(
                          "İYİLEŞEN SAYISI", snapshot.data.dailyRecovered),
                      newCoronaStatisticsCard(
                          "TOPLAM TEST SAYISI", snapshot.data.tested),
                      newCoronaStatisticsCard(
                          "TOPLAM VAKA SAYISI", snapshot.data.infected),
                      newCoronaStatisticsCard(
                          "TOPLAM VEFAT SAYISI", snapshot.data.deceased),
                      newCoronaStatisticsCard(
                          "TOPLAM AĞIR HASTA SAYISI", snapshot.data.critical),
                      newCoronaStatisticsCard(
                          "TOPLAM İYİLEŞEN SAYISI", snapshot.data.recovered),
                    ]),
                  ));
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
