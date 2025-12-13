import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'controllers/game.controller.dart';

class GameScreen extends GetView<GameController> {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Obx(() {
                final zoneCount = controller.zoneCount;
                final crossAxisCount = math.sqrt(zoneCount.value).toInt();

                return AspectRatio(
                  aspectRatio: 1,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(10),
                    itemCount: zoneCount.value,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) => _zoneTile(index),
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Widget _zoneTile(int index) {
    return Obx(() {
      return GestureDetector(
        onTap: () {
          if (controller.isStarted == false) {
            controller.startGame();
          }
          if (controller.isRecallPhase.value) {
            controller.onTapRecallPhase(index);
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: controller.tileColors[index] ?? Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.black,
              width: 1,
            ),
          ),
        ),
      );
    });
  }
}
