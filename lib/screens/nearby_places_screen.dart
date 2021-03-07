import 'package:flutter/material.dart';

class NearbyPlacesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("En Yakın Yerler")),
        body: Center(
          child: Text("En yakın\n-eczane\n-hastane"),
        ));
  }
}
