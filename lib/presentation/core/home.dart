import 'package:debt_tracker_mobile/presentation/core/bottom_nav.dart';
import 'package:debt_tracker_mobile/presentation/debt/debt_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
        child: DebtHome(),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
  }
}