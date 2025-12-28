import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pulse_flow/presentation/history/models/history_model.dart';
import 'package:pulse_flow/shared/app_color.dart';

import 'controllers/history.controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Obx(() {
          if (!controller.isLoaded.value) {
            return const Center(child: CircularProgressIndicator());
          }

          final runs = controller.listHistory;
          if (runs.isEmpty) {
            return emptyHistory();
          }

          return ListView(
            children: [
              summaryCard(runs),
              const SizedBox(height: 12),
              recentGraphCard(runs),
              const SizedBox(height: 12),
              recentRunsCard(runs),
            ],
          );
        }),
      ),
    );
  }

  emptyHistory() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: AppColor.themeDarkBlue,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          'No runs yet. Play a session first.',
          style: TextStyle(color: AppColor.textPrimary),
        ),
      ),
    );
  }

  summaryCard(
    List<HistoryModel> runs,
  ) {
    final total = runs.length;
    final wins = runs.where((e) => e.result == RunResult.success).length;
    final rate = total == 0 ? 0 : (wins / total * 100).round();

    return cardShell(
      'Summary',
      null,
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          stat('Runs', '$total'),
          stat('Wins', '$wins'),
          stat('Win rate', '$rate%'),
        ],
      ),
    );
  }

  recentGraphCard(List<HistoryModel> runs) {
    final recent = runs.take(10).toList().reversed.toList(); // left to right

    return cardShell(
      'Recent performance',
      'Recall ratio per session',
      SizedBox(
        height: 64,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            for (final r in recent) ...[
              Expanded(child: miniBar(r)),
              const SizedBox(width: 6),
            ],
          ],
        ),
      ),
    );
  }

  miniBar(HistoryModel run) {
    final ratio =
        run.target == 0 ? 0.0 : (run.remembered / run.target).clamp(0.0, 1.0);
    final h = 10 + (ratio * 50);

    final barColor = run.result == RunResult.success
        ? AppColor.themeGreen
        : AppColor.themeRed;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        height: h,
        decoration: BoxDecoration(
          color: barColor,
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
  }

  recentRunsCard(
    List<HistoryModel> runs,
  ) {
    final recent = runs.take(5).toList();
    return cardShell(
      'Recent runs',
      null,
      Column(
        children: recent.map((r) {
          final ratio =
              r.target == 0 ? 0 : ((r.remembered / r.target) * 100).round();
          final color = r.result == RunResult.success
              ? AppColor.themeGreen
              : AppColor.themeRed;

          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  decoration:
                      BoxDecoration(shape: BoxShape.circle, color: color),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Level ${r.level} · Session ${r.session} · $ratio%',
                    style: const TextStyle(color: AppColor.textPrimary),
                  ),
                ),
                Text(
                  _formatTime(r.timestamp),
                  style: const TextStyle(
                      color: AppColor.textSecondary, fontSize: 12),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
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

  stat(
    String label,
    String value,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(color: AppColor.neutralGrey, fontSize: 12),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: AppColor.textPrimary,
            fontSize: 18,
            fontWeight: FontWeight.w900,
          ),
        ),
      ],
    );
  }
}
