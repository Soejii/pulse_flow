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
                Expanded(
                  child: Obx(
                    () {
                      final color = controller.activeColor;
                      final activeIndex = controller.activeZoneIndex;
                      final index = 0;
                      return Container(
                        color: index == activeIndex.value
                            ? color.value
                            : Colors.white,
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                Expanded(
                  child: Obx(
                    () {
                      final color = controller.activeColor;
                      final activeIndex = controller.activeZoneIndex;
                      final index = 1;
                      return Container(
                        color: index == activeIndex.value
                            ? color.value
                            : Colors.white,
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                Expanded(
                  child: Obx(
                    () {
                      final color = controller.activeColor;
                      final activeIndex = controller.activeZoneIndex;
                      final index = 2;
                      return Container(
                        color: index == activeIndex.value
                            ? color.value
                            : Colors.white,
                      );
                    },
                  ),
                ),
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
                Expanded(
                  child: Obx(
                    () {
                      final color = controller.activeColor;
                      final activeIndex = controller.activeZoneIndex;
                      final index = 3;
                      return Container(
                        color: index == activeIndex.value
                            ? color.value
                            : Colors.white,
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                Expanded(
                  child: Obx(
                    () {
                      final color = controller.activeColor;
                      final activeIndex = controller.activeZoneIndex;
                      final index = 4;
                      return Container(
                        color: index == activeIndex.value
                            ? color.value
                            : Colors.white,
                      );
                    },
                  ),
                ),
                Container(
                  color: Colors.grey,
                  height: 10,
                ),
                Expanded(
                  child: Obx(
                    () {
                      final color = controller.activeColor;
                      final activeIndex = controller.activeZoneIndex;
                      final index = 5;
                      return Container(
                        color: index == activeIndex.value
                            ? color.value
                            : Colors.white,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
