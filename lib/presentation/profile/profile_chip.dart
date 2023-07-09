import 'package:debt_tracker_mobile/domain/user/user_profile.dart';
import 'package:flutter/material.dart';

class ProfileChip extends StatelessWidget {
  final UserProfile profile;
  final closeButtonCallback;
  const ProfileChip(this.profile, this.closeButtonCallback, {super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(profile.profilePicture?? ''),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                profile.name,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '@${profile.username}',
                style: TextStyle(
                  fontSize: 12,
                  
                ),
              ),
            ],
          )
        ]),
      ),
      Positioned(
        top: 10,
        right: 10,
        child: SizedBox(
          child: InkWell(
            radius: 30,
            borderRadius: BorderRadius.circular(30),
            child: Icon(Icons.close),
            onTap: () {
              if (closeButtonCallback != null) {
                closeButtonCallback();
              }
            },
          ),
        )
      )
    ]
    );
  }
}