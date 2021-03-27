import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CalculateCoronaRiskWithSymptomScreen extends StatefulWidget {
  @override
  _CalculateCoronaRiskWithSymptomScreenState createState() =>
      _CalculateCoronaRiskWithSymptomScreenState();
}

class _CalculateCoronaRiskWithSymptomScreenState
    extends State<CalculateCoronaRiskWithSymptomScreen> {
  bool feverAbove38Degreees = false;
  bool dryCough = false;
  bool difficultyInBreathing = false;
  bool lossOfTasteSmell = false;
  bool throatAche = false;

  static String riskRateResult = "0.0";

  String result = "";

  @override
  void initState() {
    super.initState();
    riskRateResult = "0.0";
    result = "";
  }

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
            "Şikayetlerinizi seçiniz",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        SizedBox(
          height: 30,
        ),
        CheckboxListTile(
          title: Text("Yeni başlayan 38 derece üzeri ateş"),
          onChanged: (bool value) => {
            setState(() {
              feverAbove38Degreees = value;
            })
          },
          value: feverAbove38Degreees,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: Text("Yeni başlayan kuru öksürük"),
          onChanged: (bool value) => {
            setState(() {
              dryCough = value;
            })
          },
          value: dryCough,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: Text("Yeni başlayan nefes darlığı"),
          onChanged: (bool value) => {
            setState(() {
              difficultyInBreathing = value;
            })
          },
          value: difficultyInBreathing,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: Text("Yeni başlayan tat/koku kaybı"),
          onChanged: (bool value) => {
            setState(() {
              lossOfTasteSmell = value;
            })
          },
          value: lossOfTasteSmell,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        CheckboxListTile(
          title: Text("Yeni başlayan boğaz ağrısı"),
          onChanged: (bool value) => {
            setState(() {
              throatAche = value;
            })
          },
          value: throatAche,
          controlAffinity: ListTileControlAffinity.leading,
        ),
        ElevatedButton(
          child: Text('Hesapla'),
          onPressed: () {
            int count = 0;

            if (feverAbove38Degreees) {
              count += 2;
            }

            if (dryCough) {
              count += 3;
            }

            if (lossOfTasteSmell) {
              count += 3;
            }

            if (difficultyInBreathing) {
              count += 1;
            }

            if (throatAche) {
              count += 2;
            }

            double riskRate = (count / 14) * 100;

            result = "";
            if (0 <= riskRate && riskRate < 30.0) {
              result = "Düşük";
            } else if (30 <= riskRate && riskRate < 60.0) {
              result = "Orta";
            } else if (60 <= riskRate) {
              result = "Yüksek";
            }

            var f = NumberFormat("##.##", "en_US");
            print(f.format(riskRate));

            setState(() {
              riskRateResult = f.format(riskRate);
              result = result;
            });

            print('Hesapla $riskRateResult $result');
          },
        ),
        SizedBox(
          height: 30,
        ),
        Center(
          child: Text(
            "Risk Seviyesi: $result",
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        Center(
          child: Text(
            riskRateResult.toString(),
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
      ]),
    );
  }
}
