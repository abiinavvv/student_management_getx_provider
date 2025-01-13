import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management_app/constants/color.dart';

class ProfileScreen extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final String department;
  const  ProfileScreen({super.key, required this.image, required this.name, required this.email, required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "P R O F I L E",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: black,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 25),
              CircleAvatar(
                radius: 80,
                backgroundImage: FileImage(File(image)),
              ),
              const SizedBox(height: 25),
              Text(name),
              const SizedBox(height: 25),
              Text(department),
              const SizedBox(height: 25),
              Text(email),
            ],
          ),
        ),
      ),
    );
  }
}
