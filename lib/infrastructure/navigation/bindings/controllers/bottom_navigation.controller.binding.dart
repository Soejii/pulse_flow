import 'package:get/get.dart';
import 'package:pulse_flow/presentation/home/controllers/home.controller.dart';

import '../../../../presentation/bottom_navigation/controllers/bottom_navigation.controller.dart';

class BottomNavigationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(
      () => BottomNavigationController(),
    );
      Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
