import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/controller/controller.dart';
import 'package:student_management_app/view/screens/add_screen.dart';
import 'package:student_management_app/view/screens/edit_screen.dart';
import 'package:student_management_app/view/screens/profile_screen.dart';
import 'package:student_management_app/view/screens/search_screen.dart';

class HomeScreen extends StatelessWidget {
  final controller = Get.put(Controller());
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Student Management",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
            onPressed: () {
              Get.to(() => SearchScreen(),
                  transition: Transition.leftToRightWithFade);
            },
          ),
        ],
        backgroundColor: black,
      ),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: GetBuilder<Controller>(
          builder: (controller) {
            return controller.student.isEmpty
                ? const Center(
                    child: Text("No Students Found"),
                  )
                : ListView.builder(
                    itemCount: controller.student.length,
                    itemBuilder: (context, index) {
                      return Card(
                          child: ListTile(
                        onTap: () {
                          Get.to(ProfileScreen());
                        },
                        leading: CircleAvatar(
                            radius: 25,
                            backgroundImage: FileImage(
                                File(controller.student[index].imageurl))),
                        title: Text(controller.student[index].name),
                        subtitle: Text(controller.student[index].department),
                        trailing: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                Get.to(() => EditScreen(
                                  student: controller.student[index],
                                ));
                              },
                              icon: const Icon(Icons.edit),
                              color: black,
                            ),
                            IconButton(
                              onPressed: () {
                                controller.deleteStudent(
                                    controller.student[index].id!);
                              },
                              icon: const Icon(Icons.delete),
                              color: black,
                            ),
                          ],
                        ),
                      ));
                    });
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.to(() => AddScreen());
        },
        label: const Text("ADD",
        style: TextStyle(color: white, fontSize: 20, fontWeight: FontWeight.w400),),
        backgroundColor: black,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        icon: Icon(
          Icons.add,
          color: white,
        ),
      ),
    );
  }
}
