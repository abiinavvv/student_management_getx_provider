import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/controller/controller.dart';
import 'package:student_management_app/view/screens/profile_screen.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  final controller = Get.find<Controller>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "SEARCH",
          style: TextStyle(color: white),
        ),
        backgroundColor: black,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Theme(
              data: ThemeData(
                  cupertinoOverrideTheme:
                      const CupertinoThemeData(primaryColor: black)),
              child: CupertinoSearchTextField(
                onChanged: (value) => controller.search(value),
                padding: EdgeInsets.all(10),
                prefixIcon: const Icon(Icons.search, color: black),
              ),
            ),
          ),
          Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: controller.studentFound.value.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        onTap: () {
                          Get.to(ProfileScreen());
                        },
                        leading: CircleAvatar(
                          backgroundImage: FileImage(File(
                              controller.studentFound.value[index].imageurl)),
                          radius: 25,
                        ),
                        title: Text(controller.studentFound.value[index].name),
                        subtitle: Text(
                            controller.studentFound.value[index].department),
                      ),
                    );
                  })))
        ],
      ),
    );
  }
}
