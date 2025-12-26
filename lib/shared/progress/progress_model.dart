class ProgressModel {
  final int currentLevel;
  final int currentSession;
  final int highestUnlockedLevel;
  final bool isFirstTime;

  const ProgressModel({
    required this.currentLevel,
    required this.currentSession,
    required this.highestUnlockedLevel,
    required this.isFirstTime,
  });

  factory ProgressModel.initial() {
    return const ProgressModel(
        currentLevel: 1,
        currentSession: 1,
        highestUnlockedLevel: 1,
        isFirstTime: true);
  }

  ProgressModel copyWith({
    int? currentLevel,
    int? currentSession,
    int? highestUnlockedLevel,
    bool? isFirstTime,
  }) {
    return ProgressModel(
      currentLevel: currentLevel ?? this.currentLevel,
      currentSession: currentSession ?? this.currentSession,
      highestUnlockedLevel: highestUnlockedLevel ?? this.highestUnlockedLevel,
      isFirstTime: isFirstTime ?? this.isFirstTime,
    );
  }

  Map<String, dynamic> toJson() => {
        'current_level': currentLevel,
        'current_session': currentSession,
        'highest_unlocked_level': highestUnlockedLevel,
      };

  factory ProgressModel.fromJson(Map<String, dynamic> json) {
    return ProgressModel(
      currentLevel: (json['currentLevel'] as num?)?.toInt() ?? 1,
      currentSession: (json['currentSession'] as num?)?.toInt() ?? 1,
      highestUnlockedLevel:
          (json['highestUnlockedLevel'] as num?)?.toInt() ?? 1,
      isFirstTime: true,
    );
  }
}
