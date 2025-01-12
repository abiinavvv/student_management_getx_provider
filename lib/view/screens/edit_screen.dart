import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/controller/controller.dart';
import 'package:student_management_app/model/student.dart';
import 'package:student_management_app/view/widget/text_field.dart';

class EditScreen extends StatelessWidget {
  final Student student;
  EditScreen({super.key, required this.student});
  final controller = Get.put(Controller());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = student.name;
    ageController.text = student.age.toString();
    departmentController.text = student.department;
    emailController.text = student.email;
    final imagePicker = ImagePicker();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "EDIT",
          style: TextStyle(color: white),
        ),
        backgroundColor: black,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(onTap: () async {
                final PickedImage = await imagePicker.pickImage(
                  source: ImageSource.gallery,
                );
                if (PickedImage != null) {
                  controller.imagePick(PickedImage.path);
                }
              }, child: Obx(
                () {
                  return controller.imagePath.isNotEmpty
                      ? CircleAvatar(
                          radius: 80,
                          backgroundImage:
                              FileImage(File(controller.imagePath.value)),
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(File(student.imageurl)),
                          radius: 80,
                        );
                },
              )),
              const SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.name,
                  label: "Name",
                  validate: "Name is required",
                  controller: nameController),
              const SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.number,
                  label: "Age",
                  validate: "Age is Required",
                  controller: ageController),
              const SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.name,
                  label: "Department",
                  validate: "Department is required",
                  controller: departmentController),
              const SizedBox(height: 25),
              CustomTextField(
                  type: TextInputType.emailAddress,
                  label: "Email",
                  validate: "Email is Required",
                  controller: emailController),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  await controller.updateStudent(Student(
                      name: nameController.text,
                      age: int.parse(ageController.text),
                      department: departmentController.text,
                      email: emailController.text,
                      imageurl: controller.imagePath.value.isNotEmpty
                          ? controller.imagePath.value
                          : student.imageurl));
                  Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Student Updated Successfully"),
                        backgroundColor: black,
                      ),
                    );
                },
                style: ElevatedButton.styleFrom(backgroundColor: black),
                child: const Text("Update"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
