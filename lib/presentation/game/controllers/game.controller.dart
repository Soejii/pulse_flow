import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GameController extends GetxController {
  bool isStarted = false;
  final _random = Random();

  final activeZoneIndex = Rxn<int>();
  final activeColor = Rxn<Color>();

  final count = 0.obs;
  @override
  void onInit() {
    super.onInit();
    isStarted = true;
  }

  @override
  void onReady() {
    super.onReady();
    _gameLoop();
  }

  @override
  void onClose() {
    super.onClose();
    isStarted = false;
  }

  Future<void> _gameLoop() async {
    while (isStarted) {
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
    activeZoneIndex.value = null;
    activeColor.value = null;
  }

  Color _pickColor() {
    final p = _random.nextDouble();

    if (p < 0.30) {
      print('real');
      return Colors.green;
    } else if (p < 0.40) {
      print('lure');
      return const Color(0xFF4CAF60);
    } else {
      print('distractor');
      return _random.nextBool() ? Colors.red : Colors.blue;
    }
  }
}
