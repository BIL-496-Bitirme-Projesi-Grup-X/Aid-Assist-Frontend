import 'package:aid_assist/providers/auth.dart';
import 'package:aid_assist/ui/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PsychologicalSupportScreen extends StatelessWidget {
  Future<void> _launchInBrowser(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: <String, String>{'my_header_key': 'my_header_value'},
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    const number = "123";
    return SingleChildScrollView(
        child: Container(
      child: Column(children: <Widget>[
        newPsychologicalSupportCard(
            "PSİKOLOJİK DESTEK ÜNİTESİ", Colors.white, () => {}),
        newPsychologicalSupportCard(
            "Afet süresince ortaya çıkabilecek psikolojik tepkiler nelerdir?",
            Colors.black,
            () => _launchInBrowser(
                'http://' + Auth.hostAddress + "/static/afet_surecince.pdf")),
        newPsychologicalSupportCard(
            "Afet kaynaklı yaşadığınız psikolojik problemler için neler yapabilirsiniz?",
            Colors.black,
            () => _launchInBrowser('http://' +
                Auth.hostAddress +
                "/static/neler_yapilabilir.pdf")),
        newPsychologicalSupportCard(
            "Aile İl Sağlık Müdürlüğü Sağlıklı Hayat Merkezi Hızlı Erişim",
            Colors.black,
            () => launch("tel:03704333126")),
        newPsychologicalSupportCard(
            "Aile Çalışma ve Sosyal Hizmetler İl Müdürlüğü",
            Colors.black,
            () => launch("tel:03704122902")),
      ]),
    ));
  }
}
