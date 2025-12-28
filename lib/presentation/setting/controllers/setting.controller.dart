import 'package:get/get.dart';
import 'package:pulse_flow/presentation/history/controllers/history.controller.dart';
import 'package:pulse_flow/shared/audio/audio_service.dart';
import 'package:pulse_flow/shared/progress/progress_controller.dart';

class SettingController extends GetxController {
  final audio = Get.find<AudioService>();
  final progress = Get.find<ProgressController>();
  final history = Get.find<HistoryController>();

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}
