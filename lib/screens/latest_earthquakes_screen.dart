import 'package:flutter/material.dart';

class LatestEarthquakesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Anlık Deprem Listesi (Güncel)")),
        body: Center(
          child: Text('Anlık Deprem Listesi (Güncel)'),
        ));
  }
}
