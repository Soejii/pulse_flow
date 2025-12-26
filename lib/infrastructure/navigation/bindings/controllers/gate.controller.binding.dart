import 'package:get/get.dart';

import '../../../../presentation/gate/controllers/gate.controller.dart';

class GateControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GateController>(
      () => GateController(),
    );
  }
}
