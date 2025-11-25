import 'package:get/get.dart';
import 'package:pulse_flow/presentation/home/controllers/home.controller.dart';


class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}
