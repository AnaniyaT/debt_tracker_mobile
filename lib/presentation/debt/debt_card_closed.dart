import 'package:debt_tracker_mobile/application/user/profile/profile_bloc.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/domain/debt/debt_model.dart';
import 'package:debt_tracker_mobile/domain/user/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DebtCardClosed extends StatefulWidget {
  final Debt debt;
  const DebtCardClosed(this.debt, {super.key});

  @override
  State<DebtCardClosed> createState() => _DebtCardClosedState();
}

class _DebtCardClosedState extends State<DebtCardClosed> {
  void getProfile() async {
    final me = await PreferenceService.getUser();
    if (me.id == widget.debt.borrower) {
      context.read<ProfileBloc>().add(GetProfileById(widget.debt.lender));
    } else {
      context.read<ProfileBloc>().add(GetProfileById(widget.debt.borrower));
    }
  }

  @override
  void initState() {
    getProfile();
    super.initState();
  }

  Color getStatusColor(String status) {
    switch (status) {
      case 'approved':
        return Colors.yellow;
      case 'paid':
        return Colors.green;
      case 'declined':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String getStatusText(status) {
    switch (status) {
      case 'approved':
        return 'Awaiting Payment';
      case 'paid':
        return 'Paid';
      case 'declined':
        return 'Declined';
      default:
        return 'Awaiting Approval';
    }
  }

  @override
  build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width  - 40,
      child: Padding(
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                color: getStatusColor(widget.debt.status),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                child: Text(getStatusText(widget.debt.status),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    )),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            BlocBuilder<ProfileBloc, ProfileState>(
              builder: (context, state) {
                if(state is ProfileSuccess) {
                  return Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                      foregroundImage: NetworkImage(
                          'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(state.profile.name,
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        Text('@${state.profile.username}',
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: Colors.white)),
                      ],
                    ),
                  ],
                );
                }
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 24,
                      backgroundColor: Colors.grey,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 100,
                          height: 20,
                          color: Colors.grey,
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          width: 50,
                          height: 10,
                          color: Colors.grey,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                FutureBuilder<User>(
                    future: PreferenceService.getUser(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          decoration: BoxDecoration(
                            color: snapshot.data?.id == widget.debt.borrower
                                ? Colors.red
                                : Colors.green,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 5),
                            child: Text(
                                snapshot.data?.id == widget.debt.borrower
                                    ? '-${widget.debt.amount} Birr'
                                    : '${widget.debt.amount} Birr',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black87)),
                          ),
                        );
                      } else {
                        return Container();
                      }
                    }),
                SizedBox(width: 20),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Text(
                        widget.debt.requestedDate.toString().split(' ')[0],
                        style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
