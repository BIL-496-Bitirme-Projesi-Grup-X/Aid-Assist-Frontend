import 'package:aid_assist/providers/auth.dart';
import 'package:aid_assist/screens/call_emergency_numbers_screen.dart';
import 'package:aid_assist/screens/daily_corona_statistics_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MainDrawer extends StatelessWidget {
  Widget buildListTile(String title, IconData icon, Function tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 20,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

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
    return Drawer(
        child: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Container(
            height: 80,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              '#AidAssist',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 30,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          SizedBox(
            height: 1,
          ),
          buildListTile('Anasayfa', Icons.home, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Afet öncesi bilgilendirme', Icons.star, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Afet sonrası bilgilendirme', Icons.star, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Alo yardım', Icons.star, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CallEmergencyNumbersScreen(),
              ),
            );
          }),
          buildListTile('Sağlık bakanlığı', Icons.star, () {
            _launchInBrowser('https://www.saglik.gov.tr/');
          }),
          buildListTile('Korona önlem', Icons.star, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Güncel istatistik', Icons.star, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DailyCoronaStatisticsScreen(),
              ),
            );
          }),
          buildListTile('Hakkımızda ', Icons.star, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          Divider(),
          buildListTile(
            'Çıkış Yap',
            Icons.exit_to_app,
            () {
              Navigator.of(context).pop();
              Navigator.of(context).pushReplacementNamed('/');
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
        ],
      ),
    ));
  }
}
