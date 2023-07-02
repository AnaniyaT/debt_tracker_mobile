import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _pageInd = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(25, 10, 25, 20),
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
              transitionDuration: Duration(milliseconds: 400),
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
                return Container(
                  child: Center(child: Text('Add')),
                );
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
