import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  bool isStarted = false;
  final _random = Random();

  final activeZoneIndex = Rxn<int>();
  final activeColor = Rxn<Color>();

  int playerCount = 0;
  int realStimuliCount = 0;
  int maxLoop = 20;
  int currentLoop = 0;
  final isTrue = false.obs;

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
    isStarted = false;
  }

  void startGame() async {
    isStarted = true;
    playerCount = 0;
    currentLoop = 0;
    realStimuliCount = 0;
    await _gameLoop();
  }

  Future<void> _gameLoop() async {
    while (isStarted) {
      print('Current Loop at $currentLoop');
      _showStimulus();
      await Future.delayed(Duration(milliseconds: 1000));
      _hideStimulus();
      await Future.delayed(Duration(milliseconds: 500));
    }
  }

  _showStimulus() {
    activeZoneIndex.value = _random.nextInt(6);
    activeColor.value = _pickColor();
    print('Showing at $activeZoneIndex');
  }

  _hideStimulus() {
    currentLoop++;
    activeZoneIndex.value = null;
    activeColor.value = null;

    if (currentLoop >= maxLoop) {
      isStarted = false;
      Future.delayed(Duration(milliseconds: 300), () {
        _showResultDialog();
      });
    }
  }

  Color _pickColor() {
    final p = _random.nextDouble();

    if (p < 0.30) {
      print('real');
      isTrue.value = true;
      realStimuliCount++;
      return Colors.green;
    } else if (p < 0.40) {
      print('lure');
      isTrue.value = false;
      return const Color(0xFF4CAF60);
    } else {
      print('distractor');
      isTrue.value = false;
      return _random.nextBool() ? Colors.red : Colors.blue;
    }
  }

  void _showResultDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text('Game Finished'),
        content: Text(
          'You hit $playerCount out of $realStimuliCount stimuli',
          style: const TextStyle(fontSize: 16),
        ),
        actions: [
          TextButton(
            onPressed: () {
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
