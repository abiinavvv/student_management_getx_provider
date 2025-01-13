import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_management_app/constants/color.dart';
import 'package:student_management_app/provider/provider.dart';
import 'package:student_management_app/view/screens/add_screen.dart';
import 'package:student_management_app/view/screens/edit_screen.dart';
import 'package:student_management_app/view/screens/profile_screen.dart';
import 'package:student_management_app/view/screens/search_screen.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<DBProvider>(builder: (context, value, child) {
      return Scaffold(
        appBar: AppBar(
          title: const Text(
            'STUDENT RECORD',
            style: TextStyle(color: white),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Search()));
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
          child: value.student.isEmpty
              ? const Center(
                  child: Text("No students added"),
                )
              : ListView.builder(
                  itemCount: value.student.length,
                  itemBuilder: (context, index) {
                    return Card(
                        child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Profile(
                                    image: value.student[index].imgurl,
                                    name: value.student[index].name,
                                    department: value.student[index].department,
                                    email: value.student[index].email)));
                      },
                      leading: CircleAvatar(
                        radius: 25,
                        backgroundImage:
                            FileImage(File(value.student[index].imgurl)),
                      ),
                      title: Text(value.student[index].name),
                      subtitle: Text(value.student[index].department),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Edit(
                                              student: value.student[index],
                                            )));
                              },
                              icon: const Icon(
                                Icons.edit,
                                color: black,
                              )),
                          IconButton(
                              onPressed: () {
                                value.deleteStudent(value.student[index].id!);
                              },
                              icon: const Icon(Icons.delete, color: black))
                        ],
                      ),
                    ));
                  }),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => const Add()));
          },
          backgroundColor: black,
          child: const Icon(
            Icons.add,
            color: white,
          ),
        ),
      );
    });
  }
}