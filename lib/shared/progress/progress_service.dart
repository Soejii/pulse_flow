import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pulse_flow/shared/progress/progress_model.dart';

class ProgressService {
  static const key = 'progress_state';

  Future<ProgressModel> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(key);
    if (raw == null) return ProgressModel.initial();

    try {
      final map = jsonDecode(raw) as Map<String, dynamic>;
      return ProgressModel.fromJson(map);
    } catch (_) {
      return ProgressModel.initial();
    }
  }

  Future<void> save(ProgressModel state) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, jsonEncode(state.toJson()));
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
