import 'package:debt_tracker_mobile/application/debt/debt_bloc.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/presentation/debt/debt_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/debt/debt.dart';

class DebtList extends StatefulWidget {
  const DebtList({super.key});

  @override
  State<DebtList> createState() => _DebtListState();
}

class _DebtListState extends State<DebtList> {
  @override
  void initState() {
    if (context.read<DebtBloc>().state is DebtSuccessMultiple) {
      setState(() {
        debts = (context.read<DebtBloc>().state as DebtSuccessMultiple).debts.reversed.toList();
      });
      classify(debts);
    }
    super.initState();
  }

  void classify(debts) async {
    String me = (await PreferenceService.getUser()).id;
    List<Debt> active = [];
    List<Debt> incoming = [];
    List<Debt> outgoing = [];

    for (Debt debt in debts) {
      if (debt.status == 'pending') {
        if (debt.borrower == me) {
          outgoing.add(debt);
        } else {
          incoming.add(debt);
        }
      } else {
        active.add(debt);
      }
    }
    setState(() {
      debtLists = [active, incoming, outgoing];
    });
  }

  int selected = 0;
  List<Debt> debts = [];

  // 0 for active, 1 for incoming, 2 for outgoing
  List<List<Debt>> debtLists = [[], [], []];

  @override
  Widget build(BuildContext context) {
    return BlocListener<DebtBloc, DebtState>(
      listener: (context, state) {
        if (state is DebtSuccessMultiple) {
          setState(() {
            debts = state.debts.reversed.toList();
          });
          classify(debts);
        }

        if (state is DebtEditSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Color.fromARGB(255, 136, 126, 126),
            ),
          );
          BlocProvider.of<DebtBloc>(context).add(GetDebts());
        }

        if (state is DebtFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.failure.message),
              backgroundColor: Color.fromARGB(255, 136, 126, 126),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Debts'),
        ),
        body: SafeArea(
            child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SelectBtn(
                  text: 'Active',
                  onTap: () {
                    setState(() {
                      selected = 0;
                    });
                  },
                  ind: 0,
                  curr: selected,
                ),
                SelectBtn(
                  text: 'Incoming',
                  onTap: () {
                    setState(() {
                      selected = 1;
                    });
                  },
                  ind: 1,
                  curr: selected,
                ),
                SelectBtn(
                  text: 'Outgoing',
                  onTap: () {
                    setState(() {
                      selected = 2;
                    });
                  },
                  ind: 2,
                  curr: selected,
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: BlocBuilder<DebtBloc, DebtState>(
                builder: (context, state) {
                  if (state is DebtSuccessMultiple) {
                    return RefreshIndicator(
                      onRefresh: () async {
                        context.read<DebtBloc>().add(GetDebts());
                        await Future.delayed(Duration(seconds: 1));
                      },
                      child: ListView.builder(
                        itemCount: debtLists[selected].length,
                        itemBuilder: (context, index) => Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: DebtCard(debtLists[selected][index]),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: 3,
                      itemBuilder: (context, index) => Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: DebtCardSkeleton(),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                        ],
                      ),
                    );
                  }
                },
              ),
            )
          ],
        )),
      ),
    );
  }
}

class SelectBtn extends StatelessWidget {
  final String text;
  final onTap;
  final int curr;
  final int ind;
  const SelectBtn(
      {required this.text,
      this.onTap,
      required this.ind,
      required this.curr,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      enableFeedback: false,
      child: Container(
        width: 100,
        height: 40,
        decoration: BoxDecoration(
          color: ind == curr ? Colors.black87 : Colors.grey[300],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: ind == curr ? Colors.white : Colors.black87,
              fontSize: 15,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
