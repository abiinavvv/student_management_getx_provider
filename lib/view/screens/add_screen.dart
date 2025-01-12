import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/controller/controller.dart';
import 'package:student_management_app/model/student.dart';
import 'package:student_management_app/view/widget/text_field.dart';

class AddScreen extends StatelessWidget {
  AddScreen({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
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
              GestureDetector(onTap: () async {
                final image =
                    await imagePicker.pickImage(source: ImageSource.gallery);
                if (image != null) {
                  controller.imagePick(image.path);
                }
              }, child: Obx(
                () {
                  return controller.imagePath.isNotEmpty
                      ? CircleAvatar(
                          radius: 60,
                          backgroundImage:
                              FileImage(File(controller.imagePath.value)),
                        )
                      : const CircleAvatar(
                          radius: 80,
                          backgroundColor: black,
                          foregroundColor: white,
                          child: Icon(
                            Icons.person,
                            size: 70,
                          ),
                        );
                },
              )),
              SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.name,
                  label: "Name",
                  validate: "Name is Required",
                  controller: nameController),
              SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.number,
                  label: "Age",
                  validate: "Age is Required",
                  controller: ageController),
              SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.name,
                  label: "Department",
                  validate: "Department is Required",
                  controller: departmentController),
              SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.emailAddress,
                  label: "Email",
                  validate: "Email is required",
                  controller: emailController),
              SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  if (formkey.currentState!.validate()) {
                    if (controller.imagePath.string == null) {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Please select an image"),
                        backgroundColor: black,
                      ));
                      return;
                    }
                    final student = Student(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        department: departmentController.text,
                        email: emailController.text,
                        imageurl: controller.imagePath.string);
                    controller.addStudent(student);
                    Get.back();
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
                ),
                child: const Text("REGISTER", style: TextStyle(color: white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
