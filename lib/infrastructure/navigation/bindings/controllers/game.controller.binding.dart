import 'package:get/get.dart';
import 'package:pulse_flow/presentation/game/controllers/game.controller.dart';


class GameControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(
      () => GameController(),
    );
  }
}
