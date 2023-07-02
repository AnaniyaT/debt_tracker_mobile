import 'package:debt_tracker_mobile/presentation/auth/authPage.dart';
import 'package:debt_tracker_mobile/presentation/core/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'application/auth/auth_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Poppins',
            primaryColor: Colors.white,
            scaffoldBackgroundColor: Colors.white,
            buttonTheme: const ButtonThemeData(
              buttonColor: Colors.lightBlueAccent,
              textTheme: ButtonTextTheme.primary,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              floatingLabelStyle: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            )),
        home: HomePage());
  }
}
