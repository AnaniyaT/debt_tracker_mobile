import 'package:debt_tracker_mobile/presentation/core/bottom_nav.dart';
import 'package:debt_tracker_mobile/presentation/debt/debt_home.dart';
import 'package:debt_tracker_mobile/presentation/profile/profile_home.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  int _pageInd = 0;
  final _controller = ScrollController();

  void changePage(int index) {
    if (index == _pageInd) return;
    _controller.animateTo(
      index * MediaQuery.of(context).size.width,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    setState(() {
      
      _pageInd = index;
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      extendBody: true,
      body: ListView(
        itemExtent: MediaQuery.of(context).size.width,
        controller: _controller,
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: DebtHome(),
            ),
            Container(
              width: MediaQuery.of(context).size.width,
              child: ProfilePage(),
            ),
          ],
        ),
      bottomNavigationBar: BottomNavBar(changePage),
    );
  }
}
