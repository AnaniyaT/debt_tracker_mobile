import 'package:animations/animations.dart';
import 'package:debt_tracker_mobile/application/user/profile/profile_bloc.dart';
import 'package:debt_tracker_mobile/presentation/debt/request_debt.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar(this.callback, {super.key});
  final callback;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageInd = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 15, 25, 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              decoration: BoxDecoration(
                color:_pageInd == 0 ? Color.fromARGB(31, 102, 98, 98) : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    widget.callback(0);
                    setState(() {
                      _pageInd = 0;
                    });
                  },
                  icon: const Icon(
                    Icons.leaderboard_rounded,
                    size: 30,
                    color: Colors.black87,
                    ),
                ),
              ),
            ),
            OpenContainer(
              transitionType: ContainerTransitionType.fade,
              closedColor: Colors.black87,
              closedShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              closedBuilder: (context, action) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 20),
                child: IconButton(
                  enableFeedback: false,
                  onPressed: action,
                  color: Colors.white,
                  icon: const Icon(Icons.add,size: 30,),
                ),
              ),
              openBuilder: (context, action) {
                return BlocProvider<ProfileBloc>(
                  create: (context) => ProfileBloc(),
                  child: RequestDebtPage())
                  ;
              },
            ),
            Container(
              decoration: BoxDecoration(
                color: _pageInd == 1 ? Color.fromARGB(31, 102, 98, 98) : Colors.transparent,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                child: IconButton(
                  enableFeedback: false,
                  onPressed: () {
                    widget.callback(1);
                    setState(() {
                      _pageInd = 1;
                    });
                  },
                  icon: const Icon(
                    Icons.settings,
                    color: Colors.black87,
                    size: 29.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
