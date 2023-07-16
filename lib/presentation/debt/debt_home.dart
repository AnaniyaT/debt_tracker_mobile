import 'dart:math';
import 'package:debt_tracker_mobile/common/failure.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:go_router/go_router.dart';
import 'package:skeletons/skeletons.dart';
import 'package:animations/animations.dart';
import 'package:debt_tracker_mobile/application/debt/debt_bloc.dart';
import 'package:debt_tracker_mobile/domain/debt/debt_model.dart';
import 'package:debt_tracker_mobile/presentation/debt/debt_card.dart';
import 'package:debt_tracker_mobile/presentation/debt/debts_list.dart';
import 'package:debt_tracker_mobile/presentation/debt/overview_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtHome extends StatefulWidget {
  const DebtHome({super.key});

  @override
  State<DebtHome> createState() => _DebtHomeState();
}

class _DebtHomeState extends State<DebtHome> {
  @override
  void initState() {
    super.initState();
    context.read<DebtBloc>().add(GetDebts());
  }

  void setDebtAmounts(List<Debt> debts) async {
    double amountOwed = 0;
    double amountOwing = 0;
    int peopleOwed = 0;
    int peopleOwing = 0;

    String me = (await PreferenceService.getUser()).id;

    for (Debt debt in debts) {
      if (debt.status == 'approved') {
        if (debt.borrower == me) {
          amountOwing += debt.amount;
          peopleOwing++;
        } else {
          amountOwed += debt.amount;
          peopleOwed++;
        }
      }
    }

    setState(() {
      this.amountOwed = amountOwed;
      this.amountOwing = amountOwing;
      this.peopleOwed = peopleOwed;
      this.peopleOwing = peopleOwing;
    });
  }

  double amountOwed = 0;
  double amountOwing = 0;
  int peopleOwed = 0;
  int peopleOwing = 0;

  List<Debt> debts = [
    Debt(
        id: '1',
        lender: '1231',
        borrower: '1231',
        amount: 100,
        requestedDate: DateTime.now(),
        paid: false,
        status: 'pending'),
    Debt(
        id: '2',
        lender: '1231',
        borrower: '1231',
        amount: 200,
        requestedDate: DateTime.now(),
        paid: false,
        status: 'approved'),
    Debt(
        id: '3',
        lender: '1231',
        borrower: '1234',
        amount: 300,
        requestedDate: DateTime.now(),
        paid: true,
        status: 'paid'),
    Debt(
        id: '4',
        lender: '1231',
        borrower: '1231',
        amount: 400,
        requestedDate: DateTime.now(),
        paid: false,
        status: 'declined'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('Debt Tracker')),
        body: RefreshIndicator(
          onRefresh: () {
            context.read<DebtBloc>().add(GetDebts());
            return Future.delayed(Duration(seconds: 1));
          },
          child: SizedBox(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: BlocConsumer<DebtBloc, DebtState>(
                listener: (context, state) {
                  if (state is DebtSuccessMultiple) {
                    setState(() {
                      debts = state.debts.reversed.toList();
                    });
                    setDebtAmounts(state.debts);
                  }

                  if (state is DebtEditSuccess) {
                    BlocProvider.of<DebtBloc>(context).add(GetDebts());
                  }

                  if (state is DebtFailure) {
                    if (state.failure is NotAuthenticatedFailure) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Not Authenticated. Please login again.'),
                          backgroundColor: Color.fromARGB(255, 136, 126, 126),
                        ),
                      );
                      PreferenceService.removeAuthToken();
                      GoRouter.of(context).go('/');
                    } else 
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(state.failure.message),
                        backgroundColor: Color.fromARGB(255, 136, 126, 126),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(20, 15, 20, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Overview',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87)),
                            SizedBox(
                              height: 10,
                            ),
                            (state is DebtSuccessMultiple)
                                ? OverviewCard(
                                    'Owe Me',
                                    amountOwed,
                                    peopleOwed,
                                  )
                                : OverviewCardSkeleton(),
                            SizedBox(
                              height: 15,
                            ),
                            (state is DebtSuccessMultiple)
                                ? OverviewCard(
                                    'I Owe', amountOwing, peopleOwing)
                                : OverviewCardSkeleton(),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Recent Debts',
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black87)),
                                OpenContainer(
                                  closedShape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  closedColor: Colors.black87,
                                  openBuilder: (context, action) =>
                                      BlocProvider.value(
                                    value: context.read<DebtBloc>(),
                                    child: DebtList(),
                                  ),
                                  closedBuilder: (context, action) => Container(
                                    width: 90,
                                    height: 40,
                                    child: Center(
                                      child: Text(
                                        'View All',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                
                      ScrollConfiguration(
                        behavior: ScrollBehavior(),
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(decelerationRate: ScrollDecelerationRate.normal),
                          clipBehavior: Clip.antiAlias,
                          scrollDirection: Axis.horizontal,
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, top: 30),
                            child: Row(
                              children: [
                                for (var debt
                                    in debts.sublist(0, min(4, debts.length)))
                                  Row(
                                    children: [
                                      (state is DebtSuccessMultiple)
                                          ? DebtCard(
                                              debt,
                                              home: true,
                                            )
                                          : DebtCardSkeleton(home: true,),
                                      SizedBox(
                                        width: 20,
                                      )
                                    ],
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 110,
                      ),
                    ],
                  );
                },
              ),
            ),
          ),
        ));
  }
}
