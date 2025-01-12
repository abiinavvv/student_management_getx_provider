import 'package:get/get.dart';
import 'package:student_management_app/controller/controller.dart';

class GetxBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Controller());
  }
}