import 'package:flutter/material.dart';

import 'constants.dart';

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