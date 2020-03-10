import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:quiz/ui/home.dart';

void main() {
  // Only allow portrait orientation
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  // This widget is the root of application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz',
      theme: ThemeData(
          accentColor: Colors.indigo,
          primarySwatch: Colors.blue,
          fontFamily: "Roboto",
          buttonColor: Colors.blue,
          buttonTheme: ButtonThemeData(
              buttonColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              textTheme: ButtonTextTheme.primary)),
      home: MyHomePage(),
    );
  }
}
