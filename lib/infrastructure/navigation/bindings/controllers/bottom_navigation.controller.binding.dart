import 'package:get/get.dart';
import 'package:pulse_flow/presentation/bottom_navigation/controllers/bottom_navigation.controller.dart';
import 'package:pulse_flow/presentation/history/controllers/history.controller.dart';
import 'package:pulse_flow/presentation/home/controllers/home.controller.dart';

class BottomNavigationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BottomNavigationController>(
      () => BottomNavigationController(),
    );
      Get.lazyPut<HomeController>(
      () => HomeController(),
    );
        Get.lazyPut<HistoryController>(
      () => HistoryController(),
    );
  }
}
