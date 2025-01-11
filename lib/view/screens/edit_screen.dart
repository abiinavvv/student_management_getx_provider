import 'package:flutter/material.dart';
import 'package:student_management_app/constants/color.dart';

class EditScreen extends StatelessWidget {
  const EditScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
              GestureDetector(
                onTap: () async {},
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: black,
                ),
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "name",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "name is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: "Age",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Age is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                  labelText: "Department",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Department is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "Email",
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: black, width: 2),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email is required";
                  }
                  return null;
                },
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Student Updated Successfully"),
                        backgroundColor: black,
                      ),
                    );
                  }
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
