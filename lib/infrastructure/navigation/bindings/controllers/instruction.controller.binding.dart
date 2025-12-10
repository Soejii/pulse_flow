import 'package:get/get.dart';

import '../../../../presentation/instruction/controllers/instruction.controller.dart';

class InstructionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InstructionController>(
      () => InstructionController(),
    );
  }
}
