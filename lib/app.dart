import 'package:flutter/material.dart';
import 'modules/splash/splash_page.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'superherois',
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xffF5F5F5),
        fontFamily: 'Roboto',
        primarySwatch: Colors.blue,
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xff202020),
          elevation: 0,
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
        ),
      ),
      home: const SplashPage(),
    );
  }
}