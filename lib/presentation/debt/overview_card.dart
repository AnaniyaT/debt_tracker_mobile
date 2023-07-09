import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class OverviewCard extends StatelessWidget {
  final String title;
  final double amount;
  final int people;
  const OverviewCard(this.title, this.amount, this.people, {super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$title',
          style: TextStyle(
              fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black54),
        ),
        SizedBox(
          height: 4,
        ),
        Container(
          decoration: BoxDecoration(
              color: Colors.black87,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 1,
                  blurRadius: 7,
                  offset: const Offset(0, 2), // changes position of shadow
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$amount Birr',
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 5,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.person_outline_rounded,
                      size: 15,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      people == 1 ? '$people Person' :
                      '$people People',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class OverviewCardSkeleton extends StatelessWidget {
  const OverviewCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SkeletonAvatar(
          style: SkeletonAvatarStyle(
            width: 70,
            height: 20,
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.grey[700],
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 100,
                  height: 30,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 80,
                  height: 15,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
