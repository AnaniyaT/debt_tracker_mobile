import 'package:debt_tracker_mobile/data/local/shared_preferences/preference_service.dart';
import 'package:debt_tracker_mobile/presentation/core/generic_dialog.dart';
import 'package:debt_tracker_mobile/presentation/profile/my_profile.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  void logout(context) async {
    bool confirm = await showDialog(context: context, builder: (context) => GenericDialog(text: 'Logout',));
    if (!confirm) return;
    PreferenceService.logout();
    GoRouter.of(context).go('/auth');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    MyProfile(),
                    Divider(),
                    SizedBox(height: 20,),
                    ProfileActionButton(label: 'Edit Profile', icon: Icons.edit, onPressed: () {},),
                    SizedBox(height: 20,),
                    ProfileActionButton(label: 'History', icon: Icons.history, onPressed: () {},),
                    SizedBox(height: 20,),
                    Divider()
                  ],
                ),
              ),
             
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ProfileActionButton(label: 'Delete Account', icon: Icons.delete, onPressed: () {},),
                    SizedBox(height: 20,),
                    ProfileActionButton(label: 'logout', icon: Icons.logout, onPressed: () {
                      logout(context);
                    }),
                  ],
                  
                        ),
              )
          ]),
        ),
      ),
    );
  }
}

class ProfileActionButton extends StatelessWidget {
  final String label;
  final IconData? icon;
  final Function? onPressed;
  const ProfileActionButton({required this.label, this.onPressed, this.icon,super.key});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
              onPressed: () {
                if (onPressed != null) {
                  onPressed!();
                }
              },
              style: ElevatedButton.styleFrom(
                
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Row(children: [
                  icon != null ? Icon(icon, size: 30,) : SizedBox(width: 10,),
                  SizedBox(width: 20,),
                  Text(label),
                ],),
              )
    );
  }
}