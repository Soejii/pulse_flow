enum RunResult { success, fail }

class HistoryModel {
  final DateTime timestamp;
  final int level;
  final int session;
  final int gridSize;
  final int remembered;
  final int target;
  final RunResult result;

  const HistoryModel({
    required this.timestamp,
    required this.level,
    required this.session,
    required this.gridSize,
    required this.remembered,
    required this.target,
    required this.result,
  });

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp.toIso8601String(),
        'level': level,
        'session': session,
        'gridSize': gridSize,
        'remembered': remembered,
        'target': target,
        'result': result.name,
      };

  factory HistoryModel.fromJson(Map<String, dynamic> json) {
    return HistoryModel(
      timestamp: DateTime.parse(json['timestamp']),
      level: json['level'],
      session: json['session'],
      gridSize: json['gridSize'],
      remembered: json['remembered'],
      target: json['target'],
      result: RunResult.values.firstWhere(
        (e) => e.name == json['result'],
      ),
    );
  }
}
