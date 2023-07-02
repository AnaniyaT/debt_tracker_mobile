import 'package:debt_tracker_mobile/presentation/debt/debt_card.dart';
import 'package:debt_tracker_mobile/presentation/debt/overview_card.dart';
import 'package:flutter/material.dart';

class DebtHome extends StatefulWidget {
  const DebtHome({super.key});

  @override
  State<DebtHome> createState() => _DebtHomeState();
}

class _DebtHomeState extends State<DebtHome> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Debt Overview',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        SizedBox(
          height: 10,
        ),
        // Row(
        //   children: [

        //     Expanded(child: Card('Owe Me', 100, 2)),
        //     SizedBox(width: 20,),
        //     Expanded(child: Card('I Owe', 100, 2)),
        //   ],
        // ),
        OverviewCard('Owe Me', 100, 2),
        SizedBox(
          height: 15,
        ),
        OverviewCard('I Owe', 100, 2),
        SizedBox(
          height: 20,
        ),
        Text('Recent Transactions',
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        SizedBox(
          height: 20,
        ),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              DebtCard(),
              SizedBox(
                width: 20,
              ),
              DebtCard(),
            ],
          ),
        )
      ],
    ));
  }
}
