import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/game.controller.dart';

class GameScreen extends GetView<GameController> {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                zoneBox(0),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                zoneBox(1),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                zoneBox(2),
              ],
            ),
          ),
          Container(
            color: Colors.grey,
            width: 10,
          ),
          Expanded(
            child: Column(
              children: [
                zoneBox(3),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                zoneBox(4),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                zoneBox(5),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget zoneBox(int index) {
    return Expanded(
      child: Obx(
        () {
          final color = controller.activeColor;
          final activeIndex = controller.activeZoneIndex;
          return GestureDetector(
            onTap: () {
              if (controller.isRecallPhase.value) {
                controller.onTapRecallPhase(index);
              }
            },
            child: Container(
              color: index == activeIndex.value ? color.value : Colors.white,
            ),
          );
        },
      ),
    );
  }
}
