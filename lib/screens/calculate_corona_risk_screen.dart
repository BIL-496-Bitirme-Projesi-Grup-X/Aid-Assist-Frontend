import 'package:aid_assist/screens/calculate_corona_risk_no_symptom_screen.dart';
import 'package:aid_assist/screens/calculate_corona_risk_with_symptom_screen.dart';
import 'package:flutter/material.dart';

class CalculateCoronaRiskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Korona Riskini Hesapla")),
      body: Column(children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            "Merhaba, Bugün nasıl hissediyorsun?",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 50.0),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 100),
          decoration: BoxDecoration(border: Border.all(color: Colors.green)),
          child: new GestureDetector(
            onTap: () => {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CalculateCoronaRiskNoSymptomScreen(),
                  ))
            },
            child: Text("Çok iyiyim"),
          ),
        ),
        new Container(
            margin: const EdgeInsets.only(top: 50.0),
            padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 80),
            decoration: BoxDecoration(border: Border.all(color: Colors.green)),
            child: new GestureDetector(
              onTap: () => {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          CalculateCoronaRiskWithSymptomScreen(),
                    ))
              },
              child: Text("İyi hissetmiyorum"),
            )),
      ]),
    );
  }
}
