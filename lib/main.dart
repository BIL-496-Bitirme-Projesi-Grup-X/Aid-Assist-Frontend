import 'package:aid_assist/screens/auth_screen.dart';
import 'package:aid_assist/screens/tabs_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/main_screen.dart';
import './providers/auth.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
        ],
        child: Consumer<Auth>(
            builder: (ctx, auth, _) => MaterialApp(
                  title: 'Aid Assist',
                  theme: ThemeData(
                    primarySwatch: Colors.green,
                    accentColor: Colors.lime,
                    canvasColor: Color.fromRGBO(255, 254, 229, 1),
                    fontFamily: 'Raleway',
                    textTheme: ThemeData.light().textTheme.copyWith(
                        bodyText2: TextStyle(
                          color: Color.fromRGBO(20, 51, 51, 1),
                        ),
                        bodyText1: TextStyle(
                          color: Color.fromRGBO(20, 51, 51, 1),
                        ),
                        headline6: TextStyle(
                          fontSize: 20,
                          fontFamily: 'RobotoCondensed',
                        )),
                  ),
                  initialRoute: '/',
                  routes: {
                    '/': (ctx) => auth.isAuth
                        ? TabsScreen()
                        : FutureBuilder(
                            future: auth.tryAutoLogin(),
                            builder: (ctx, authResultSnapshot) => AuthScreen(),
                          ),
                  },
                  onUnknownRoute: (settings) {
                    return MaterialPageRoute(
                      builder: (ctx) => MainScreen(),
                    );
                  },
                )));
  }
}
