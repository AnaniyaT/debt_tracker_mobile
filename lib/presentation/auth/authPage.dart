import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/presentation/auth/signin.dart';
import 'package:debt_tracker_mobile/presentation/auth/signup.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}


class _AuthPageState extends State<AuthPage> {
  int _pageInd = 0;

  void changePage() {
    setState(() {
      _pageInd = _pageInd == 0 ? 1 : 0;
    });
  }

  void redirectIfLoggedin() async {
    bool isLogged = await PreferenceService.isLogged();
    if (isLogged) {
      GoRouter.of(context).go('/home');
    }
  }

  @override
  void initState() {
    super.initState();
    // redirectIfLoggedin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20,),
              const SizedBox(
                    height: 50,
                    child: Image(
                      image: AssetImage('assets/images/semicircle.png'),
                    )),
                const SizedBox(height: 35.0),
                _pageInd == 0 ? SigninPage(changePage: changePage,) : SignupPage(changePage: changePage,),
            ],
          )
        ),
      ),
    );
  }
}