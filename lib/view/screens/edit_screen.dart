import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/controller/controller.dart';
import 'package:student_management_app/model/student.dart';
import 'package:student_management_app/view/widget/text_field.dart';

class Edit extends StatelessWidget {
  final Student student;
  Edit({super.key, required this.student});
  final controller = Get.put(Controller());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController departmentController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = student.name;
    departmentController.text = student.department;
    ageController.text = student.age.toString();
    emailController.text = student.email;
    final imgPicker = ImagePicker();

    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(
        foregroundColor: white,
        title: const Text(
          'EDIT',
        ),
        backgroundColor: blue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(25),
        child: Form(
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
                          backgroundImage: FileImage(File(controller.imagePath.value)),
                          radius: 80,
                        )
                      : CircleAvatar(
                          backgroundImage: FileImage(File(student.imgurl!)),
                          radius: 80,
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
                 
                    
                    await controller.updateStudent(Student(
                      id: student.id,
                        name: nameController.text,
                        age: int.parse(ageController.text),
                        department: departmentController.text,
                        email: emailController.text,
                        imgurl: controller.imagePath.value.isNotEmpty
                        ?controller.imagePath.value
                        :student.imgurl));
                    Get.back();

                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                      content: Text('Updated successfully'),
                      backgroundColor: blue,
                    ));
               
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