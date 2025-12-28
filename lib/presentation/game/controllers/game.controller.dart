import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse_flow/presentation/history/controllers/history.controller.dart';
import 'package:pulse_flow/presentation/history/models/history_model.dart';
import 'package:pulse_flow/shared/audio/audio_service.dart';
import 'package:pulse_flow/shared/progress/progress_controller.dart';

class GameController extends GetxController {
  final progressController = Get.find<ProgressController>();
  final historyController = Get.find<HistoryController>();
  final audio = Get.find<AudioService>();

  bool isHard = Get.arguments;

  @override
  void onInit() {
    super.onInit();
    tileColors.value = List<Color?>.filled(zoneCount.value, null);
    remainingTiles = List.generate(zoneCount.value, (i) => i);

    final s = progressController.state.value;

    currentLevel = s.currentLevel;
    currentWinning = s.currentSession - 1;
    zoneCount.value = zoneCountList[currentLevel - 1];

    resetRunState();
    _reinitBoard();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    _instructionDialog();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  var isRecallPhase = false.obs;
  bool isStarted = false;

  final _random = Random();

  List<int> correctSequenceList = [];
  List<int> playerSequenceList = [];
  int targetGreenCount = 0;
  int currentGreenCount = 0;
  var zoneCount = 9.obs;
  List<int> remainingTiles = [];

  int currentWinning = 0;
  int needsToWin = 3;
  int currentLevel = 1;
  List<int> zoneCountList = [9, 16, 25, 36];
  final targetGreenCountRange = [(3, 6), (5, 9), (7, 13), (10, 18)];

  // psuedo rng shi
  int distractorFailStreak = 0;
  double baseDistractorChance = 0.3;
  double distractorIncrement = 0.1;

  var tileColors = <Color?>[].obs;

  void startGame() async {
    resetRunState();
    _reinitBoard();
    isStarted = true;
    _sequenceLoop();
  }

  void resetRunState() {
    correctSequenceList = [];
    playerSequenceList = [];
    currentGreenCount = 0;
    isRecallPhase.value = false;
    distractorFailStreak = 0;
    final range = targetGreenCountRange[currentLevel - 1];
    targetGreenCount = range.$1 + _random.nextInt(range.$2 - range.$1 + 1);
    isStarted = false;
  }

  void _reinitBoard() {
    tileColors.value = List<Color?>.filled(zoneCount.value, null);
    remainingTiles = List.generate(zoneCount.value, (i) => i);
  }

  void setLevel(int levelIndex) async {
    currentLevel = levelIndex;
    await progressController.setCurrentLevel(levelIndex);
    zoneCount.value = zoneCountList[levelIndex - 1];
    resetRunState();
    _reinitBoard();
    isStarted = false;
  }

  Future<void> _sequenceLoop() async {
    while (remainingTiles.isNotEmpty) {
      _showColor();
      await Future.delayed(const Duration(milliseconds: 700));
      if (isHard) {
        tileColors.value = List<Color?>.filled(zoneCount.value, null);
      }
    }
    isRecallPhase.value = true;
    tileColors.value = List<Color?>.filled(zoneCount.value, null);
  }

  onTapRecallPhase(int index) async {
    tileColors[index] = Colors.green;
    _checkSequence(index);
    await Future.delayed(Duration(milliseconds: 500));
  }

  _checkSequence(int tappedIndex) async {
    if (playerSequenceList.isNotEmpty) {
      if (correctSequenceList[playerSequenceList.length] == tappedIndex) {
        playerSequenceList.add(tappedIndex);
        if (correctSequenceList.length == playerSequenceList.length) {
          currentWinning++;
          successSound();
          _showSuccessDialog();
        }
      } else {
        currentWinning = 0;
        failSound();
        _showFailedDialog();
      }
    } else {
      if (correctSequenceList[0] == tappedIndex) {
        playerSequenceList.add(tappedIndex);
      } else {
        _showFailedDialog();
      }
    }
  }

  bool _shouldBeGreen() {
    if (currentGreenCount >= targetGreenCount) {
      return false;
    }

    final remainingSlots = remainingTiles.length + 1;

    final remainingGreensNeeded = targetGreenCount - currentGreenCount;

    if (remainingGreensNeeded >= remainingSlots) {
      return true;
    }

    final isDistractorFromRng = psuedoRng();
    return !isDistractorFromRng;
  }

  bool psuedoRng() {
    final chance =
        (baseDistractorChance + distractorFailStreak * distractorIncrement)
            .clamp(0.0, 1.0);

    final roll = _random.nextDouble();

    if (roll < chance) {
      distractorFailStreak = 0;
      return true;
    } else {
      distractorFailStreak++;
      return false;
    }
  }

  void _showColor() {
    if (remainingTiles.isEmpty) {
      return;
    }

    final pickIdx = _random.nextInt(remainingTiles.length);
    final index = remainingTiles.removeAt(pickIdx);

    final color = _pickColor(index);

    tileColors[index] = color;
    tileColors.refresh();

    print('Showing at $index, color $color');
  }

  Color _pickColor(int index) {
    final bool isGreen = _shouldBeGreen();

    if (!isGreen) {
      print('distractor');
      return _random.nextBool() ? Colors.red : Colors.blue;
    } else {
      print('correct sequence');
      correctSequenceList.add(index);
      currentGreenCount++;
      return Colors.green;
    }
  }

  tapSound() {
    audio.playTap();
  }

  successSound() {
    audio.playSuccess();
  }

  failSound() {
    audio.playFail();
  }

  void _showSuccessDialog() async {
    if (Get.context == null) return;
    Get.dialog(
      AlertDialog(
        title: Text(
          'Sesi Berakhir',
          style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        content: Text(
          currentWinning == needsToWin
              ? 'Lanjut Ke Level Berikutnya?'
              : 'Anda Menang $currentWinning dari $needsToWin sesi yang ada',
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              if (currentWinning == needsToWin) {
                setLevel(currentLevel + 1);
                currentWinning = 0;
              }

              historyController.addHistory(
                HistoryModel(
                  timestamp: DateTime.now(),
                  level: currentLevel,
                  session: currentWinning + 1,
                  gridSize: zoneCount.value,
                  remembered: playerSequenceList.length,
                  target: correctSequenceList.length,
                  result: RunResult.success,
                ),
              );

              progressController.setProgress(
                progressController.state.value.copyWith(
                  currentLevel: currentLevel,
                  currentSession: currentWinning + 1,
                  highestUnlockedLevel: max(
                    progressController.state.value.highestUnlockedLevel,
                    currentLevel,
                  ),
                ),
              );
              resetRunState();
              _reinitBoard();
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
            ),
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showFailedDialog() async {
    if (Get.context == null) return;
    Get.dialog(
      AlertDialog(
        title: Text(
          'Permainan Selesai',
          style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        content: Text(
          'Kamu Mengingat ${playerSequenceList.length} dari ${correctSequenceList.length}',
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              resetRunState();
              _reinitBoard();
              historyController.addHistory(
                HistoryModel(
                  timestamp: DateTime.now(),
                  level: currentLevel,
                  session: currentWinning,
                  gridSize: zoneCount.value,
                  remembered: playerSequenceList.length,
                  target: correctSequenceList.length,
                  result: RunResult.fail,
                ),
              );

              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
            ),
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _instructionDialog() {
    if (Get.context == null) return;

    Get.dialog(
      AlertDialog(
        title: Text(
          'Perhatian!',
          style: Theme.of(Get.context!).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
        ),
        content: Text(
          'Ketuk Dimana Saja Dalam Kotak Untuk Memulai Permainan',
          style: Theme.of(Get.context!).textTheme.bodyMedium,
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF00E676),
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
              elevation: 10,
            ),
            child: const Text(
              'OK',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
