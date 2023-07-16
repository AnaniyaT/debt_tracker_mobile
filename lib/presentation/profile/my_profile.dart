import 'package:flutter/material.dart';

class MyProfile extends StatelessWidget {
  const MyProfile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          SizedBox(height: 50,),
          CircleAvatar(
            radius: 70,
            backgroundImage: AssetImage('assets/images/avatar.jpg'),
          ),
          SizedBox(height: 20,),
          Text('John Doe', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
          SizedBox(height: 10,),
          Text('@johndoe'),
          SizedBox(height: 20,),
          
        ],
      )
    );
  }
}