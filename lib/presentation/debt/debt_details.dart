import 'package:debt_tracker_mobile/application/debt/debt_bloc.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/domain/debt/debt_model.dart';
import 'package:debt_tracker_mobile/presentation/debt/debt_info_card.dart';
import 'package:debt_tracker_mobile/presentation/profile/profile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtDetails extends StatelessWidget {
  final Debt debt;
  const DebtDetails(this.debt, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<DebtBloc, DebtState>(
          listener: (context, state) {
            if (state is DebtEditSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Color.fromARGB(255, 136, 126, 126),
                ),
              );
              BlocProvider.of<DebtBloc>(context).add(GetDebts());
            }
    
            if(state is DebtFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.failure.message),
                  backgroundColor: Color.fromARGB(255, 136, 126, 126),
                ),
              );
            }
          },
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black87,
                      ),
                      child: InkWell(
                        enableFeedback: false,
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text('Debt Details',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ))
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      FutureBuilder(
                          future: PreferenceService.getUser(),
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: Colors.black12,
                                ),
                                child: Text(
                                    snapshot.data?.id == debt.borrower
                                        ? 'Lender'
                                        : 'Borrower',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black54,
                                    )),
                              );
                            }
                            return Container();
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      ProfileCard(debt),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                          padding: EdgeInsets.all(20),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.black12,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Description',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black54,
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              // Center(
                              //   child: Text("No description provided.")
                              // )
                              Text(debt.description!.isEmpty ? 'No description provided :(' : debt.description!)
                            ],
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      DebtInfoCard(debt),
                      SizedBox(
                        height: 40,
                      ),
                      DebtActionButtons(debt)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DebtActionButtons extends StatelessWidget {
  final Debt debt;
  const DebtActionButtons(this.debt, {super.key});

  String leftButtonText(String me) {
    if (debt.borrower == me) {
      if (debt.status == 'pending') return 'Cancel';
    } else {
      if (debt.status == 'pending')
        return 'Decline';
      else if (debt.status == 'approved') return 'Delete';
    }
    return '';
  }

  String rightButtonText(String me) {
    if (debt.lender == me) {
      if (debt.status == 'pending')
        return 'Accept';
      else
        return 'Confirm Payment';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PreferenceService.getUser(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            String me = snapshot.data!.id;
            return Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (!(debt.status == 'approved' && debt.borrower == me))
                    ? ElevatedButton(
                        onPressed: () {
                          switch (leftButtonText(me)) {
                            case 'Cancel':
                              BlocProvider.of<DebtBloc>(context)
                                  .add(DeleteRequest(debt.id));
                            case 'Decline':
                              BlocProvider.of<DebtBloc>(context)
                                  .add(DeclineDebt(debt.id));
                            case 'Delete':
                              BlocProvider.of<DebtBloc>(context)
                                  .add(DeleteApproved(debt.id));
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.close),
                            Text(leftButtonText(me)),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          enableFeedback: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    : Container(),
                SizedBox(
                  width: 20,
                ),
                (debt.lender == me)
                    ? ElevatedButton(
                        onPressed: () {
                          switch (rightButtonText(me)) {
                            case 'Accept':
                              BlocProvider.of<DebtBloc>(context)
                                  .add(ApproveDebt(debt.id));
                            case 'Confirm Payment':
                              BlocProvider.of<DebtBloc>(context)
                                  .add(ConfirmDebt(debt.id));
                          }
                        },
                        child: Row(
                          children: [
                            Icon(Icons.check),
                            Text(rightButtonText(me)),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          enableFeedback: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      )
                    : Container(),
              ],
            );
          } else {
            return Container();
          }
        });
  }
}
