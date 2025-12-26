import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pulse_flow/infrastructure/navigation/routes.dart';
import 'package:pulse_flow/shared/progress/progress_controller.dart';

import 'controllers/gate.controller.dart';

class GateScreen extends GetView<GateController> {
  GateScreen({super.key});
  final progress = Get.find<ProgressController>();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        if (!progress.isLoaded.value) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        final isFirstTime = progress.state.value.isFirstTime;
        Future.microtask(
          () {
            Get.offAllNamed(
                isFirstTime ? Routes.INSTRUCTION : Routes.BOTTOM_NAVIGATION);
          },
        );
        return const SizedBox.shrink();
      },
    );
  }
}
