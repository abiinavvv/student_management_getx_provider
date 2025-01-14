import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/model/student.dart';
import 'package:student_management_app/provider/provider.dart';
import 'package:student_management_app/view/widgets/custom_textfield.dart';

class Edit extends StatelessWidget {
  final Student student;
  Edit({super.key, required this.student});

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
    return Consumer<DBProvider>(builder: (context, value, child) {
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
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {
                      final pickedImage = await imgPicker.pickImage(
                        source: ImageSource.gallery,
                      );
                      if (pickedImage != null) {
                        value.imagePick(pickedImage.path);
                      }
                    },
                    child: value.imagePath.isNotEmpty
                        ? CircleAvatar(
                            backgroundImage: FileImage(File(value.imagePath)),
                            radius: 80,
                          )
                        : CircleAvatar(
                            backgroundImage: FileImage(File(student.imgurl)),
                            radius: 80,
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
                      if (value.imagePath.isEmpty) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Select an image"),
                          backgroundColor: blue,
                        ));
                        return;
                      }
                      var std = Student(
                          name: nameController.text,
                          age: int.parse(ageController.text),
                          department: departmentController.text,
                          email: emailController.text,
                          imgurl: value.imagePath,
                          id: student.id);
                      value.updateStudent(std);
                      log(std.toString());
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Updated successfully'),
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
    });
  }
}