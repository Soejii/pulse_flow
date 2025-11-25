import 'package:get/get.dart';

import '../../../../presentation/game/controllers/game.controller.dart';

class GameControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GameController>(
      () => GameController(),
    );
  }
}
