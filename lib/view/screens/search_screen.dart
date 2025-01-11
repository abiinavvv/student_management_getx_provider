import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:student_management_app/constants/color.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
          CupertinoSearchTextField(
            padding: EdgeInsets.all(10),
            prefixIcon: const Icon(Icons.search, color: black),
          ),
        ],
      ),
    );
  }
}
