import 'package:get/get.dart';

class BottomNavigationController extends GetxController {
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

  var shellIndex = 0.obs;

  changeIndex(int newIndex) {
    shellIndex.value = newIndex;
    print('changed index to $newIndex');
  }
}
