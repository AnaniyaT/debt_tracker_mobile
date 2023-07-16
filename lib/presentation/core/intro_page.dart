import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../data/local/shared_preferences/preference_service.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  Future<bool> isLogged() async {
    return await PreferenceService.isLogged();
  }
  

  @override
  Widget build(BuildContext context) {

    Future.delayed(const Duration(milliseconds: 900), () async {
      final isLogged = await this.isLogged();
      if (isLogged) {
        GoRouter.of(context).go('/home');
      } else {
        GoRouter.of(context).go('/auth');
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                height: 80,
                width: 80,
              child: Image(image: AssetImage('assets/images/semicircle.png'))),
            const SizedBox(height: 20,),
            const Text('Debt Tracker', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          ],
        ),
      ),
    );
  }
}