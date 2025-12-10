import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/instruction.controller.dart';

class InstructionData {
  final String title;
  final String body;
  final List<String> bullets;

  const InstructionData({
    required this.title,
    required this.body,
    required this.bullets,
  });
}

class InstructionScreen extends GetView<InstructionController> {
  const InstructionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: controller.skip,
                child: const Text('Skip'),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                itemCount: controller.pages.length,
                onPageChanged: (index) {
                  controller.currentPage.value = index;
                },
                itemBuilder: (context, index) {
                  final page = controller.pages[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 16,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Text(
                          page.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          page.body,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 16),
                        ...page.bullets.map(
                          (b) => Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text('• '),
                                Expanded(
                                  child: Text(
                                    b,
                                    style:
                                        Theme.of(context).textTheme.bodyMedium,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
              child: Row(
                children: [
                  Row(
                    children: List.generate(
                      controller.pages.length,
                      (index) {
                        return Obx(
                          () => AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            margin: const EdgeInsets.only(right: 6),
                            height: 8,
                            width:
                                index == controller.currentPage.value ? 20 : 8,
                            decoration: BoxDecoration(
                              color: index == controller.currentPage.value
                                  ? Theme.of(context).colorScheme.primary
                                  : Theme.of(context).disabledColor,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: controller.goToNextPage,
                    child: Obx(
                      () => Text(
                        controller.currentPage.value ==
                                controller.pages.length - 1
                            ? 'Mulai!'
                            : 'Selanjutnya',
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
