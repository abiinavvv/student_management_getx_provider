import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/controller/controller.dart';
import 'package:student_management_app/view/screens/add_screen.dart';
import 'package:student_management_app/view/screens/edit_screen.dart';
import 'package:student_management_app/view/screens/profile_screen.dart';
import 'package:student_management_app/view/screens/search_screen.dart';

class Home extends StatelessWidget {
  final controller = Get.put(Controller());

  Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'STUDENT RECORD',
          style: TextStyle(color: white),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() =>  Search(),
                  transition: Transition.rightToLeftWithFade);
            },
            icon: const Icon(
              Icons.search,
              color: white,
            ),
          ),
        ],
        backgroundColor: black,
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GetBuilder<Controller>(
            builder: (controller) {
              return controller.student.isEmpty
                  ? const Center(
                      child: Text("No students added"),
                    )
                  : ListView.builder(
                      itemCount: controller.student.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          onTap: () {
                            Get.to(Profile(
                                image: controller.student[index].imgurl!,
                                name: controller.student[index].name,
                                email: controller.student[index].email,
                                department:
                                    controller.student[index].department));
                          },
                          leading: CircleAvatar(
                            backgroundImage: FileImage(
                                File(controller.student[index].imgurl!)),
                            radius: 25,
                          ),
                          title: Text(controller.student[index].name),
                          subtitle: Text(controller.student[index].department),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Get.to(() => Edit(student: controller.student[index]));
                                  },
                                  icon: const Icon(
                                    Icons.edit,
                                    color: black,
                                  )),
                              IconButton(
                                  onPressed: () {
                                    controller.deleteStudent(
                                        controller.student[index].id!);
                                  },
                                  icon: const Icon(Icons.delete, color: black))
                            ],
                          ),
                        ));
                      });
            },
          )),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => Add());
        },
        backgroundColor: black,
        label: const Text(
          "Add Student ",
          style: TextStyle(
              color: white, fontSize: 20, fontWeight: FontWeight.w400),
        ),
        icon: const Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }
}