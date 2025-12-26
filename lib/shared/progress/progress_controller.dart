import 'package:get/get.dart';
import 'package:pulse_flow/shared/progress/progress_model.dart';
import 'package:pulse_flow/shared/progress/progress_service.dart';

class ProgressController extends GetxController {
  final _storage = ProgressService();

  final state = ProgressModel.initial().obs;
  final isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
    _load();
  }

  Future<void> _load() async {
    state.value = await _storage.load();
    isLoaded.value = true;
  }

  Future<void> setProgress(ProgressModel next) async {
    state.value = next;
    await _storage.save(next);
  }

  Future<void> setCurrentLevel(int level) async {
    final next = state.value.copyWith(
      currentLevel: level,
      highestUnlockedLevel: level > state.value.highestUnlockedLevel
          ? level
          : state.value.highestUnlockedLevel,
    );
    await setProgress(next);
  }

  Future<void> setSession(int session) async {
    await setProgress(state.value.copyWith(currentSession: session));
  }

  Future<void> unlockLevel(int level) async {
    if (level <= state.value.highestUnlockedLevel) return;
    await setProgress(state.value.copyWith(highestUnlockedLevel: level));
  }

  Future<void> setFirstTime() async {
    await setProgress(
      state.value.copyWith(
        isFirstTime: false,
      ),
    );
  }

  Future<void> reset() async {
    await setProgress(ProgressModel.initial());
  }
}
