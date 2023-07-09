import 'package:debt_tracker_mobile/domain/debt/debt.dart';
import 'package:flutter/material.dart';

class DebtInfoCard extends StatelessWidget {
  final Debt debt;
  const DebtInfoCard(this.debt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black12,
      ),
      child: Column(
        children: [
          DebtInfoEntry('Debt Id:', debt.id),
          SizedBox(height: 20,),
          DebtInfoEntry('Amount:', debt.amount.toString()),
          SizedBox(height: 20,),
          DebtInfoEntry('Status:', debt.status),
          SizedBox(height: 20,),
          DebtInfoEntry('Requested Date:', debt.requestedDate.toString().split(' ')[0]),
          SizedBox(height: 20,),
          DebtInfoEntry('Approved Date:', debt.approvedDate.toString() != 'null' ? debt.approvedDate.toString().split(' ')[0] : 'Not Approved'),
          SizedBox(height: 20,),
          DebtInfoEntry('Paid Date:', debt.paidDate.toString() != 'null' ? debt.paidDate.toString().split(' ')[0] : 'Not Paid')
        ],
      )
    );
  }
}


class DebtInfoEntry extends StatelessWidget {
  final String r1;
  final String r2;
  const DebtInfoEntry(this.r1, this.r2, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(r1,
          style: TextStyle(
            color: Colors.black54,
          ),
        ),
        Text(r2,
          style: TextStyle(
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
        )
      ]
    );
  }
}
