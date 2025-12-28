import 'package:get/get.dart';
import 'package:pulse_flow/presentation/history/history_service.dart';
import 'package:pulse_flow/presentation/history/models/history_model.dart';

class HistoryController extends GetxController {
  final _storage = HistoryService();

  var listHistory = <HistoryModel>[].obs;

  final isLoaded = false.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
    loadHistory();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void addHistory(HistoryModel model) {
    listHistory.add(model);
    _storage.saveAll(listHistory);
  }

  void loadHistory() async {
    listHistory.value = await _storage.load();
    isLoaded.value = true;
  }
}
