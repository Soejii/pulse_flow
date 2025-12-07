import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    tileColors.value = List<Color?>.filled(zoneCount, null);
    remainingTiles = List.generate(zoneCount, (i) => i);
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
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
  int targetGreenCount = 5;
  int currentGreenCount = 0;
  int zoneCount = 9;
  List<int> remainingTiles = [];

  // psuedo rng shi
  int distractorFailStreak = 0;
  double baseDistractorChance = 0.2;
  double distractorIncrement = 0.01;

  var tileColors = <Color?>[].obs;

  void startGame() async {
    resetState();
    isStarted = true;
    _sequenceLoop();
  }

  void resetState() {
    correctSequenceList = [];
    playerSequenceList = [];
    currentGreenCount = 0;
    isRecallPhase.value = false;
    distractorFailStreak = 0;
    isStarted = false;
    tileColors.value = List<Color?>.filled(zoneCount, null);
    remainingTiles = List.generate(zoneCount, (i) => i);
  }

  Future<void> _sequenceLoop() async {
    while (remainingTiles.isNotEmpty) {
      _showColor();
      await Future.delayed(const Duration(milliseconds: 700));
    }
    isRecallPhase.value = true;
    tileColors.value = List<Color?>.filled(zoneCount, null);
  }

  onTapRecallPhase(int index) async {
    tileColors[index] = Colors.green;
    _checkSequence(index);
    await Future.delayed(Duration(milliseconds: 500));
  }

  _checkSequence(int tappedIndex) {
    if (playerSequenceList.isNotEmpty) {
      if (correctSequenceList[playerSequenceList.length] == tappedIndex) {
        playerSequenceList.add(tappedIndex);
        if (correctSequenceList.length == playerSequenceList.length) {
          _showSuccessDialog();
        }
      } else {
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

  void _showSuccessDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Game Finished'),
        content: Text(
          'You Memorized Everything!',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              resetState();
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  void _showFailedDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Game Finished'),
        content: Text(
          'You Memorized ${playerSequenceList.length} / ${correctSequenceList.length}',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
              resetState();
              Get.back();
            },
            child: const Text('OK'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }
}
