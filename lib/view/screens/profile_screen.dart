import 'package:flutter/material.dart';
import 'package:student_management_app/constants/color.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("P R O F I L E",
          style: TextStyle(color: Colors.white),
      ),
      backgroundColor: black,
    ),
    body: Center(child: Padding(padding: const EdgeInsets.all(25),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 25),
        CircleAvatar(
          radius: 80,
          ),
          const SizedBox(height: 25),
          Text("Student.name"),
          const SizedBox(height: 25),
          Text("Student.department"),
          const SizedBox(height: 25),
          Text("student.email"),
          
      ],
    ),),),
    );
  }
}