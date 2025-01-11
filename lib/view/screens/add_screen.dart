import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_app/constants/color.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    String? imagepath;
    final imagePicker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "REGISTER STUDENT",
          style: TextStyle(color: white),
        ),
        backgroundColor: black,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(25),
        child: Form(
          key: formkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () async {
                  final image =
                      await imagePicker.pickImage(source: ImageSource.gallery);
                  if (image != null) {
                    imagepath = image.path;
                  }
                },
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: FileImage(File(imagepath!)),
                ),
              ),
              SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "name is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Age is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Department",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Department is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              SizedBox(height: 25),
              ElevatedButton(onPressed: () async {
                if (formkey.currentState!.validate()) {
                  if (imagepath == null) {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text("Please select an image"),
                      backgroundColor: black,
                    ));
                    return;
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Student Registered Successfully"),
                      backgroundColor: black,
                    ),
                  );
                }
              },
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(black),
              ), child: const Text("REGISTER", style: TextStyle(color: white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
