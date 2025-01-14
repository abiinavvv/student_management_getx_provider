import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/controller/controller.dart';
import 'package:student_management_app/model/student.dart';
import 'package:student_management_app/view/widget/text_field.dart';

class Add extends StatelessWidget {
  Add({super.key});
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    final imgPicker = ImagePicker();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        title: const Text(
          'REGISTERATION',
        ),
        backgroundColor: blue,
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
                final pickedImage = await imgPicker.pickImage(
                  source: ImageSource.gallery,
                );
                if (pickedImage != null) {
                  controller.imagePick(pickedImage.path);
                }
              }, child: Obx(
                () {
                  return controller.imagePath.isNotEmpty
                      ? CircleAvatar(
                          backgroundImage:
                              FileImage(File(controller.imagePath.value)),
                          radius: 80,
                        )
                      :  CircleAvatar(
                          radius: 80,
                          backgroundColor: blue,
                          foregroundColor: white,
                          child: Icon(
                            Icons.person,
                            size: 70,
                          ),
                        );
                },
              )),
              SizedBox(height: 25,),
              CustomTextField(
                  controller: nameController,
                  type: TextInputType.name,
                  label: 'Name',
                  validate: 'Name is required!'),
              SizedBox(height: 25,),
              CustomTextField(
                  controller: ageController,
                  type: TextInputType.number,
                  label: 'Age',
                  validate: 'Age is required!'),
              SizedBox(height: 25,),
              CustomTextField(
                  controller: departmentController,
                  type: TextInputType.name,
                  label: 'Department',
                  validate: 'Department is required!'),
              SizedBox(height: 25,),
              CustomTextField(
                  controller: emailController,
                  type: TextInputType.emailAddress,
                  label: 'Email',
                  validate: 'Email is required!'),
              SizedBox(height: 25,),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final student = Student(
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        department: departmentController.text,
                        email: emailController.text,
                        imgurl: controller.imagePath.string);
                    controller.addStudent(student);
                    Get.back();
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Added successfully'),
                      backgroundColor: blue,
                    ));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: blue,
                ),
                child: const Text(
                  'SAVE',
                  style: TextStyle(color: white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}