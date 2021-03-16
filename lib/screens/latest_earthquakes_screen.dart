import 'package:aid_assist/models/earthquakes.dart';
import 'package:aid_assist/ui/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LatestEarthquakesScreen extends StatefulWidget {
  @override
  _LatestEarthquakesScreenState createState() =>
      _LatestEarthquakesScreenState();
}

class _LatestEarthquakesScreenState extends State<LatestEarthquakesScreen> {
  Future<Earthquakes> fetchEarthquakes() async {
    final response =
        await http.get(Uri.https('api.orhanaydogdu.com.tr', 'deprem/live.php'));

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return EarthquakesFromJson(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load latest earthquakes');
    }
  }

  Future<Earthquakes> futureEarthquakes;
  TextStyle textStyle = new TextStyle(fontSize: textSizeSmall);

  @override
  void initState() {
    futureEarthquakes = fetchEarthquakes();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Anlık Deprem Listesi (Güncel)")),
        body: Center(
          child: Container(
            margin: EdgeInsets.only(right: 2),
            child: FutureBuilder<Earthquakes>(
              future: futureEarthquakes,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return SizedBox(
                    width: double.infinity,
                    child: DataTable(
                      columnSpacing: 8.0,
                      columns: const <DataColumn>[
                        DataColumn(
                          label: Text('Tarih'),
                        ),
                        DataColumn(
                          label: Text('Lokasyon'),
                        ),
                        DataColumn(
                          label: Text('Derinlik'),
                        ),
                        DataColumn(
                          label: Text('Büyüklük'),
                        ),
                      ],
                      rows: List<DataRow>.generate(
                        snapshot.data.result.length,
                        (int index) => DataRow(
                          color: MaterialStateProperty.resolveWith<Color>(
                              (Set<MaterialState> states) {
                            // All rows will have the same selected color.
                            if (states.contains(MaterialState.selected))
                              return Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.08);
                            // Even rows will have a grey color.
                            if (index.isEven) {
                              return Colors.grey.withOpacity(0.3);
                            }
                            return null; // Use default value for other states and odd rows.
                          }),
                          cells: <DataCell>[
                            DataCell(Text(
                                snapshot.data.result[index].date.toString())),
                            DataCell(Text(
                              snapshot.data.result[index].lokasyon.toString(),
                              style: textStyle,
                            )),
                            DataCell(Text(
                                snapshot.data.result[index].depth.toString())),
                            DataCell(Text(
                                snapshot.data.result[index].mag.toString())),
                          ],
                          //selected: selected[index],
                          //onSelectChanged: (bool? value) {
                          //  setState(() {
                          //    selected[index] = value!;
                          //  });
                          //},
                        ),
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Text("${snapshot.error}");
                }

                // By default, show a loading spinner.
                return CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
