import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse_flow/infrastructure/navigation/routes.dart';
import 'package:pulse_flow/shared/app_color.dart';
import 'package:pulse_flow/shared/progress/progress_controller.dart';

import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({super.key});

  final progress = Get.find<ProgressController>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "FOCUS PULSE",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w900,
                  letterSpacing: 4.0,
                  color: AppColor.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                "Cognitive Control Task",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: AppColor.neutralGrey,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 28),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColor.themeDarkBlue,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: AppColor.textSecondary,
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Progress",
                      style: TextStyle(
                        color: AppColor.textPrimary,
                        fontWeight: FontWeight.w700,
                        fontSize: 16,
                      ),
                    ),
                    SizedBox(height: 10),
                    Obx(
                      () => _progressRow(
                        "Current level",
                        "Level ${progress.state.value.currentLevel}",
                      ),
                    ),
                    SizedBox(height: 6),
                    Obx(
                      () => _progressRow(
                        "Session",
                        "${progress.state.value.currentSession} / 3",
                      ),
                    ),
                    SizedBox(height: 6),
                    Obx(
                      () => _progressRow(
                        "Unlocked",
                        "Up to Level ${progress.state.value.highestUnlockedLevel}",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(
                    Routes.GAME,
                    arguments: false,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.themeGreen,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "START",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(
                    Routes.GAME,
                    arguments: true,
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColor.themeRed,
                    foregroundColor: AppColor.textPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: const Text(
                    "HARD MODE",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                height: 56,
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {
                    _levelDialog();
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColor.textPrimary,
                    side: BorderSide(
                      color: AppColor.textSecondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                  ),
                  child: const Text("Level select"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

_progressRow(
  String label,
  String value,
) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(
        label,
        style: const TextStyle(
          color: AppColor.neutralGrey,
          fontSize: 14,
        ),
      ),
      Text(
        value,
        style: const TextStyle(
          color: AppColor.textPrimary,
          fontSize: 14,
          fontWeight: FontWeight.w800,
        ),
      ),
    ],
  );
}

_levelDialog() {
  final progress = Get.find<ProgressController>();

  return Get.dialog(
    barrierDismissible: true,
    Dialog(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColor.themeDarkerBlue,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select Level',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColor.textPrimary,
                ),
              ),
              Obx(
                () {
                  final state = progress.state.value;

                  return Column(
                    children: List.generate(
                      3,
                      (i) {
                        final level = i + 1;
                        final isLocked = level > state.highestUnlockedLevel;
                        final isCurrent = level == state.currentLevel;

                        return Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 12,
                          ),
                          child: _levelTile(
                            level,
                            [9, 16, 25][i],
                            isLocked,
                            isCurrent,
                            () async {
                              if (isLocked) return;
                              await progress.setProgress(
                                state.copyWith(
                                  currentLevel: level,
                                  currentSession: 1,
                                ),
                              );
                              Get.back();
                              Get.toNamed(
                                Routes.GAME,
                                arguments: false,
                              );
                            },
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

_levelTile(
  final int level,
  final int gridSize,
  final bool locked,
  final bool active,
  final VoidCallback onTap,
) {
  return InkWell(
    onTap: locked ? null : onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: active ? AppColor.themeGreen : AppColor.themeDarkerBlue,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
            color: locked ? AppColor.textSecondary : AppColor.textSecondary),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Level $level  ·  $gridSize tiles',
              style: TextStyle(
                color: locked ? AppColor.textSecondary : AppColor.textPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          if (locked)
            const Icon(Icons.lock, color: AppColor.textSecondary)
          else if (active)
            const Icon(Icons.check_circle, color: AppColor.themeGreen),
        ],
      ),
    ),
  );
}
