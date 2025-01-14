import 'dart:io';

import 'package:flutter/material.dart';
import 'package:student_management_app/constants/color.dart';

class Profile extends StatelessWidget {
  final String image;
  final String name;
  final String email;
  final String department;

  const Profile(
      {super.key,
      required this.image,
      required this.name,
      required this.email,
      required this.department});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        title: const Text(
          'PROFILE',
        ),
        backgroundColor: blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 25,
              ),
              CircleAvatar(radius: 80, backgroundImage: FileImage(File(image))),
              const SizedBox(
                height: 25,
              ),
              Text(
                name,
                style:
                    const TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                department,
                style: const TextStyle(fontSize: 15),
              ),
              const SizedBox(
                height: 25,
              ),
              Text(
                email,
                style: const TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}