import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pulse_flow/presentation/screens.dart';
import 'package:pulse_flow/shared/app_color.dart';
import 'package:pulse_flow/shared/star_background.dart';

import 'controllers/bottom_navigation.controller.dart';

class BottomNavigationScreen extends GetView<BottomNavigationController> {
  BottomNavigationScreen({super.key});

  final _tabs = [
    HomeScreen(),
    HistoryScreen(),
    SettingScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.backgroundDark,
      body: Stack(
        children: [
          const IgnorePointer(
            child: StarBackground(
              starCount: 90,
              speed: 0.22,
            ),
          ),
          Obx(
            () => IndexedStack(
              index: controller.shellIndex.value,
              children: _tabs,
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 16,
            child: SafeArea(
              top: false,
              child: Center(child: bottomNavBar(context)),
            ),
          ),
        ],
      ),
    );
  }

  bottomNavBar(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;

    // Keeps it nice on desktop too
    final widthAll = width.clamp(260.0, 520.0);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        width: widthAll,
        height: 64,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: AppColor.themeDarkBlue,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            navBarIcon(
              Icons.home,
              0,
              () => controller.changeIndex(0),
            ),
            navBarIcon(
              Icons.history_sharp,
              1,
              () => controller.changeIndex(1),
            ),
            navBarIcon(
              Icons.settings,
              2,
              () => controller.changeIndex(2),
            ),
          ],
        ),
      ),
    );
  }

  navBarIcon(
    IconData icon,
    int index,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: Obx(
        () {
          final isSelected = controller.shellIndex.value == index;
          return InkWell(
            onTap: onTap,
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              child: Icon(
                icon,
                size: 26,
                color: isSelected ? AppColor.neutralGrey : AppColor.themeDark,
              ),
            ),
          );
        },
      ),
    );
  }
}
