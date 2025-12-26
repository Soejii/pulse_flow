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
                    _progressRow(
                      "Unlocked",
                      "Up to Level ${progress.state.value.highestUnlockedLevel}",
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: () => Get.toNamed(Routes.GAME),
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
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        //todo makes a pop up
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
                  const SizedBox(width: 12),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        // todo continue using saved progress
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
                      child: const Text("Continue"),
                    ),
                  ),
                ],
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
