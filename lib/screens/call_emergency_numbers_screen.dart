import 'package:aid_assist/ui/widgets.dart';
import 'package:flutter/material.dart';

class CallEmergencyNumbersScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("ALO YARDIM")),
        body: SingleChildScrollView(
            child: Container(
          child: Column(children: <Widget>[
            newEmergencyCallCard("ACİL YARDIM","112"),
            newEmergencyCallCard("İTFAİYE","110"),
            newEmergencyCallCard("POLİS","155"),
            newEmergencyCallCard("JANDARMA","156"),
            newEmergencyCallCard("AFAD","122"),
            newEmergencyCallCard("ORMAN YANGINLARI","117"),
          ]),
        )));
  }
}
