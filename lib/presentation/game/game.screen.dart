import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse_flow/shared/app_color.dart';

import 'controllers/game.controller.dart';

class GameScreen extends GetView<GameController> {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundDark,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TopHud(controller: controller),
              const SizedBox(height: 14),
              Expanded(
                child: Center(
                  child: Obx(() {
                    final zoneCount = controller.zoneCount.value;
                    final crossAxisCount = math.sqrt(zoneCount).toInt();

                    return LayoutBuilder(
                      builder: (context, constraints) {
                        final maxWidth = constraints.maxWidth;
                        final boardSize = maxWidth.clamp(320.0, 640.0);

                        return Container(
                          width: boardSize,
                          height: boardSize,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: AppColor.themeDarkBlue,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: AppColor.themeDarkerBlue
                                  .withValues(alpha: 0.9),
                            ),
                          ),
                          child: Stack(
                            children: [
                              GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                padding: const EdgeInsets.all(6),
                                itemCount: zoneCount,
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: crossAxisCount,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) =>
                                    _zoneTile(index),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }),
                ),
              ),
              const SizedBox(height: 14),
              _BottomActions(controller: controller),
            ],
          ),
        ),
      ),
    );
  }

  Widget _zoneTile(int index) {
    return Obx(() {
      final color = controller.tileColors[index] ?? AppColor.themeDarkerBlue;

      return GestureDetector(
        onTap: () {
          if (controller.isStarted == false) {
            controller.startGame();
            return;
          }
          if (controller.isRecallPhase.value) {
            controller.tapSound();
            controller.onTapRecallPhase(index);
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 120),
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: AppColor.neutralGrey.withValues(alpha: 0.18),
              width: 1,
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 10,
                offset: const Offset(0, 6),
                color: Colors.black.withValues(alpha: 0.18),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class _TopHud extends StatelessWidget {
  const _TopHud({required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.themeDarkBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(() {
              final level = controller.currentLevel;
              final session = (controller.currentWinning + 1)
                  .clamp(1, controller.needsToWin);

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Level $level · Session $session / ${controller.needsToWin}',
                    style: const TextStyle(
                      color: AppColor.neutralGrey,
                      fontSize: 12,
                    ),
                  ),
                ],
              );
            }),
          ),
          Obx(() {
            final recall = controller.isRecallPhase.value;
            final label = recall ? 'Recall' : 'Memorize';
            final dotColor = recall ? AppColor.themeGreen : AppColor.themeBlue;

            return Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: dotColor,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: const TextStyle(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _BottomActions extends StatelessWidget {
  const _BottomActions({required this.controller});
  final GameController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColor.themeDarkBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                controller.resetRunState();
                controller.startGame();
              },
              style: OutlinedButton.styleFrom(
                side: BorderSide(
                    color: AppColor.neutralGrey.withValues(alpha: 0.25)),
                foregroundColor: AppColor.textPrimary,
              ),
              child: const Text('Restart'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: FilledButton(
              onPressed: () {
                if (!controller.isStarted) {
                  controller.startGame();
                }
              },
              style: FilledButton.styleFrom(
                backgroundColor: AppColor.themeGreen,
                foregroundColor: Colors.black,
              ),
              child: const Text('Start'),
            ),
          ),
        ],
      ),
    );
  }
}
