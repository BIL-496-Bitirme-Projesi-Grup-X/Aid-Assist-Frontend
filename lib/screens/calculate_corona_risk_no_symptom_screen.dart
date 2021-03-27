import 'package:flutter/material.dart';

class CalculateCoronaRiskNoSymptomScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Korona Riskini Hesapla")),
      body: Column(children: <Widget>[
        SizedBox(
          height: 30,
        ),
        Center(
          child: Icon(
            Icons.celebration,
            color: Colors.red,
            size: 100,
          ),
        ),
        new Container(
          margin: const EdgeInsets.only(top: 50.0),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: new GestureDetector(
            onTap: () => {},
            child: Text(
                "Semptomlarınızda herhangi bir değişiklik olursa kendinizi takip edebilir ve uygulamayı yeniden kullanabilirsiniz"),
          ),
        ),
      ]),
    );
  }
}
