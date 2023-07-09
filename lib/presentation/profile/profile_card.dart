import 'package:debt_tracker_mobile/application/user/profile/profile_bloc.dart';
import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/debt/debt_model.dart';

class ProfileCard extends StatelessWidget {
  final Debt debt;
  const ProfileCard(this.debt, {super.key});

  void initialize(callbak) async {
    String me = (await PreferenceService.getUser()).id;

    if (me == debt.borrower) {
      callbak(debt.lender);
    } else {
      callbak(debt.borrower);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileBloc(),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.black12,
        ),
        child: BlocConsumer<ProfileBloc, ProfileState>(
          listener: (context, state) {
            if (state is ProfileInitial) {
              print('initial');
              initialize((String id) {
                context.read<ProfileBloc>().add(GetProfileById(id));
              });
              print("hello");
            }
          },
          builder: (context, state) {
            if (state is ProfileInitial) {
              initialize((String id) {
                context.read<ProfileBloc>().add(GetProfileById(id));
              });
            }

            return Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.black87,
                ),
                SizedBox(
                  width: 20,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    (state is ProfileSuccess) ? Text(
                      state.profile.name,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ) : Container(
                      height: 20,
                      width: 100,
                      color: Colors.grey,
                    )
                    ,
                    (state is ProfileSuccess) ? Text(
                      '@${state.profile.username}'
                    ) :
                    Column(
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 10,
                          width: 80,
                          color: Colors.grey,
                        ),
                      ],
                    )
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
