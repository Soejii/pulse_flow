import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pulse_flow/shared/app_color.dart';

import 'controllers/setting.controller.dart';

class SettingScreen extends GetView<SettingController> {
  const SettingScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 520),
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            const SizedBox(height: 32),
            cardShell(
              'Audio',
              null,
              Column(
                children: [
                  Obx(() {
                    final musicOn = controller.audio.musicEnabled;
                    return switchRow(
                      'Music',
                      'Background music',
                      musicOn.value,
                      (v) {
                        controller.audio.setMusic(v);
                        if (v) controller.audio.playMusic();
                      },
                    );
                  }),
                  const SizedBox(height: 10),
                  Obx(() {
                    final sfxOn = controller.audio.sfxEnabled;
                    return switchRow(
                      'SFX',
                      'Tap, success, fail',
                      sfxOn.value,
                      (v) => controller.audio.setSfx(v),
                    );
                  }),
                ],
              ),
            ),
            const SizedBox(height: 12),
            cardShell(
              'Data',
              'Be careful, this cannot be undone',
              Column(
                children: [
                  actionRow(
                    'Reset progress',
                    'Back to Level 1, Session 1',
                    () async {
                      final ok = await _confirm(
                        title: 'Reset progress?',
                        message: 'This will reset your level and session.',
                      );
                      if (!ok) return;
      
                      await controller.progress.reset();
                      Get.snackbar(
                        'Done',
                        'Progress reset.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    true,
                  ),
                  const SizedBox(height: 10),
                  actionRow(
                    'Clear history',
                    'Remove all run logs',
                    () async {
                      final ok = await _confirm(
                        title: 'Clear history?',
                        message: 'This will delete all history runs.',
                      );
                      if (!ok) return;
      
                      await controller.history.clear();
                      Get.snackbar(
                        'Done',
                        'History cleared.',
                        snackPosition: SnackPosition.BOTTOM,
                      );
                    },
                    true,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            cardShell(
              'About',
              null,
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  aboutLine('App', 'Focus Pulse'),
                  const SizedBox(height: 6),
                  aboutLine('Version', '0.1.0'),
                ],
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  creditDialog() {
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
                aboutLine('Playtester', ''),
                const SizedBox(height: 6),
                aboutLine('Version', '0.1.0'),
                const SizedBox(height: 6),
              ],
            ),
          ),
        ),
      ),
    );
  }

  creditCard() {
    return GestureDetector(
      onTap: () {
        creditDialog();
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.themeDarkBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Credit',
              style: const TextStyle(
                color: AppColor.textPrimary,
                fontSize: 16,
                fontWeight: FontWeight.w800,
              ),
            ),
            Icon(Icons.info),
          ],
        ),
      ),
    );
  }

  cardShell(
    String title,
    String? subtitle,
    Widget child,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColor.themeDarkBlue,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColor.textPrimary,
              fontSize: 16,
              fontWeight: FontWeight.w800,
            ),
          ),
          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(color: AppColor.neutralGrey, fontSize: 12),
            ),
          ],
          const SizedBox(height: 12),
          child,
        ],
      ),
    );
  }

  Future<bool> _confirm(
      {required String title, required String message}) async {
    final result = await Get.dialog<bool>(
      AlertDialog(
        backgroundColor: AppColor.themeDarkBlue,
        title: Text(
          title,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontWeight: FontWeight.w800,
          ),
        ),
        content: Text(
          message,
          style: const TextStyle(color: AppColor.neutralGrey),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(result: false),
            child: const Text(
              'Cancel',
              style: TextStyle(color: AppColor.neutralGrey),
            ),
          ),
          ElevatedButton(
            onPressed: () => Get.back(result: true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColor.themeRed,
              foregroundColor: Colors.black,
            ),
            child: const Text('Yes'),
          ),
        ],
      ),
      barrierDismissible: true,
    );

    return result ?? false;
  }

  switchRow(
    String title,
    String subtitle,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: AppColor.themeDarkerBlue,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: AppColor.textPrimary,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                      color: AppColor.neutralGrey, fontSize: 12),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColor.themeGreen,
          ),
        ],
      ),
    );
  }

  actionRow(
    String title,
    String subtitle,
    VoidCallback onTap,
    bool danger,
  ) {
    final color = danger ? AppColor.themeRed : AppColor.themeGreen;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: AppColor.themeDarkerBlue,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: AppColor.textPrimary,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        color: AppColor.neutralGrey, fontSize: 12),
                  ),
                ],
              ),
            ),
            Icon(Icons.chevron_right, color: color),
          ],
        ),
      ),
    );
  }

  aboutLine(
    String label,
    String value,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 72,
          child: Text(
            label,
            style: const TextStyle(color: AppColor.neutralGrey, fontSize: 12),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(
              color: AppColor.textPrimary,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
