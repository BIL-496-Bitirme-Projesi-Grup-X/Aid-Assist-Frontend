import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'constants.dart';

Card newPsychologicalSupportCard(String title, Color color, Function function) {
  return Card(
      color: Colors.green.withOpacity(0.8),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: InkWell(
          onTap: () {
            // Function is executed on tap.
            function();
          },
          child: Center(
              child: Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, color: color),
          )),
        ),
      ));
}

Card newCoronaStatisticsCard(String title, var number) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ColoredBox(
            color: Color.fromRGBO(0, 160, 160, 0.80),
            child: SizedBox(
              width: double.infinity,
              height: 20,
              child: Center(
                  child: Text(
                title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
            )),
        ColoredBox(
            color: Color.fromRGBO(111, 111, 111, 0.80),
            child: SizedBox(
              width: double.infinity,
              height: 60,
              child: Center(
                  child: Text(
                numberFormat.format(number),
                style: TextStyle(
                    fontSize: 35,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              )),
            )),
      ],
    ),
  );
}

Card newEmergencyCallCard(String title, var number) {
  return Card(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ColoredBox(
            color: Colors.red,
            child: SizedBox(
              width: double.infinity,
              height: 20,
              child: Center(
                  child: Text(
                title,
                style:
                    TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
              )),
            )),
        ColoredBox(
          color: Color.fromRGBO(111, 111, 111, 0.80),
          child: SizedBox(
              width: double.infinity,
              height: 55,
              child: Center(
                  child: new GestureDetector(
                      onTap: () => launch("tel://" + number),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Icon(
                            Icons.call,
                            color: Colors.red,
                            size: 35,
                          ),
                          Text(
                            number,
                            style: TextStyle(
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )
                        ],
                      )))),
        ),
      ],
    ),
  );
}
