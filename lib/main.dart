import 'package:debt_tracker_mobile/application/debt/debt_bloc.dart';
import 'package:debt_tracker_mobile/presentation/auth/authPage.dart';
import 'package:debt_tracker_mobile/presentation/core/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'application/auth/auth_bloc.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text('Exit App'),
              content: Text('Are you sure you want to exit the app?'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text('No'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text('Yes'),
                ),
              ],
            ),
          );
          return false;
        },
        child: BlocProvider(
          create: (context) => DebtBloc(),
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                fontFamily: 'Poppins',
                primaryColor: Colors.white,
                primarySwatch: MaterialColor(
                  Colors.black87.value,
                  const <int, Color>{
                    50: Colors.black87,
                    100: Colors.black87,
                    200: Colors.black87,
                    300: Colors.black87,
                    400: Colors.black87,
                    500: Colors.black87,
                    600: Colors.black87,
                    700: Colors.black87,
                    800: Colors.black87,
                    900: Colors.black87,
                  },
                ),
                scaffoldBackgroundColor: Colors.white,
                inputDecorationTheme: const InputDecorationTheme(
                  floatingLabelStyle: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            routerConfig: router,
          ),
        ));
  }
}

final router = GoRouter(routes: [
  GoRoute(
    path: '/',
    builder: (context, state) => BlocProvider(
      create: (context) => AuthBloc(),
      child: AuthPage(),
    ),
  ),
  GoRoute(
    path: '/home',
    builder: (context, state) => HomePage(),
  ),
]);
