import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:rant/account.dart';
import 'package:rant/global.dart';
import 'package:rant/util/widget_switch.dart';
import 'package:rant/util/focus_fixer.dart';
import 'package:rant/views/login_view.dart';
import 'package:rant/views/home_view.dart';
import 'package:scoped/scoped.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initStore();

  runApp(Scope(store: store, child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FocusFixer(
      child: MaterialApp(
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: [const Locale('en', ''), const Locale('ro', '')],
        title: 'RANTER',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Color(0xFFFFF9EB),
          accentColor: Color(0xFFFFF9EB),
          brightness: Brightness.light,
          //fontFamily: 'SF Pro Text',
//          appBarTheme: Theme.of(context).appBarTheme.copyWith(
//                elevation: 0,
//                color: Colors.white54,
//                textTheme: TextTheme(
//                  headline6: TextStyle(
//                    color: Color(0xFF000000)
//                  ),
//                ),
//              ),
          //scaffoldBackgroundColor: Color(0xFF191C26),
        ),
        home: context.get<Account>().isAuthenticated.bindValue(
            (context, value) => WidgetSwitch(index: value ? 1 : 0, items: [
                  (context) => LoginView(),
                  (context) => HomeView(),
                ])),
      ),
    );
  }
}
