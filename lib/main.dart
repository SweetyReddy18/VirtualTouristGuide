import 'package:flutter/material.dart';
import 'package:vtg1flutter/screens/welcome_screen.dart';
import 'package:vtg1flutter/screens/registration_screen.dart';
import 'package:vtg1flutter/screens/login_screen.dart';
import 'package:vtg1flutter/screens/welcome_to_map_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WelcomeScreen(),
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        WelcomeToMapScreen.id: (context) => WelcomeToMapScreen(),
      },
    );
  }
}
