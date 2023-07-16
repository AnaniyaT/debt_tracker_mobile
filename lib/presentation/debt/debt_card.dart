import 'package:debt_tracker_mobile/application/user/profile/profile_bloc.dart';
import 'package:debt_tracker_mobile/domain/debt/debt_model.dart';
import 'package:debt_tracker_mobile/presentation/debt/debt_card_closed.dart';
import 'package:debt_tracker_mobile/presentation/debt/debt_details.dart';
import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';

class DebtCard extends StatelessWidget {
  final Debt debt;
  final bool home;
  const DebtCard(this.debt, {this.home=false,super.key});

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      closedColor: Colors.black87,
      openColor: Colors.white,
      useRootNavigator: false,
      transitionType: ContainerTransitionType.fadeThrough,
      closedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      closedBuilder: (context, action) => BlocProvider(
        create: (context) => ProfileBloc(),
        child: DebtCardClosed(debt, MediaQuery.of(context).size.width - (home? 60 : 40)),
      ),
      openBuilder: (context, action) => DebtDetails(debt),
    );
  }
}

class DebtCardSkeleton extends StatelessWidget {
  final bool home;
  const DebtCardSkeleton({this.home=false, super.key});

  @override
  Widget build(BuildContext context) {
    return Container (
      padding: EdgeInsets.all(20),
      height: 210,
      width: MediaQuery.of(context).size.width - (home ? 60 : 40),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[700]
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 80,
            height: 20,
            shape: BoxShape.rectangle,
          ),
        ),
        SizedBox(height: 20,),
        Row(
        children: [
          SkeletonAvatar(
            style: SkeletonAvatarStyle(
              width: 50,
              height: 50,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 20,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 100,
                  height: 15,
                  shape: BoxShape.rectangle,
                ),
              ),
              SizedBox(height: 10,),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 80,
                  height: 13,
                  shape: BoxShape.rectangle,
                ),
              ),
            ],
          )
        ],
        ),
        SizedBox(height: 30,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 100,
                height: 30,
                shape: BoxShape.rectangle,
              ),
            ),
            SkeletonAvatar(
              style: SkeletonAvatarStyle(
                width: 100,
                height: 30,
                shape: BoxShape.rectangle,
              ),
            ),
          ],
        ),
        
      ]),
    );
  }
}
