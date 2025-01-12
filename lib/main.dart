import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_app/controller/binding.dart';
import 'package:student_management_app/view/screens/home_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  GetxBinding().dependencies;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: GetxBinding(),
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomeScreen(),
    );
  }
}
