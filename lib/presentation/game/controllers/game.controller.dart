import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    startGame();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }

  var isRecallPhase = false.obs;

  final _random = Random();

  List<int> correctSequenceList = [];
  List<int> playerSequenceList = [];
  int maxLoop = 7;
  int currentLoop = 0;

  final activeZoneIndex = Rxn<int>();
  final activeColor = Rxn<Color>();

  void startGame() async {
    resetState();
    _sequenceLoop();
  }

  void resetState() {
    correctSequenceList = [];
    playerSequenceList = [];
    activeColor.value = null;
    activeZoneIndex.value = null;
    currentLoop = 0;
    isRecallPhase.value = false;
  }

  Future<void> _sequenceLoop() async {
    while (isRecallPhase.value == false) {
      _showColor();
      await Future.delayed(Duration(milliseconds: 1000));
      _hideColor();
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  onTapRecallPhase(int index) async {
    activeZoneIndex.value = index;
    activeColor.value = Colors.green;
    _checkSequence(index);
    await Future.delayed(Duration(milliseconds: 500));
    activeZoneIndex.value = null;
    activeColor.value = null;
    await Future.delayed(Duration(milliseconds: 300));
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

  _showColor() {
    activeZoneIndex.value = _random.nextInt(6);
    activeColor.value = _pickColor();
    print('Showing at $activeZoneIndex');
  }

  _hideColor() {
    activeZoneIndex.value = null;
    activeColor.value = null;
    currentLoop++;
    if (currentLoop >= maxLoop) {
      isRecallPhase.value = true;
    }
  }

  Color _pickColor() {
    final p = _random.nextDouble();

    if (p < 0.80) {
      print('correct sequence');
      correctSequenceList.add(activeZoneIndex.value ?? 0);
      return Colors.green;
    } else {
      print('distractor');
      return _random.nextBool() ? Colors.red : Colors.blue;
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
