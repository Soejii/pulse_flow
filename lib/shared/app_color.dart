import 'package:flutter/material.dart';

class AppColor {
  final themeBlue = hex('225577');
  final themeGreen = hex('00A682');
  final themeRed = hex('E45651');
  final themeDarkBlue = hex('212835');
  final themeDarkerBlue = hex('12161F');
  final themeDark = hex('0C1017');

  final backgroundDark = hex('0C1017');

  final textPrimary = hex('E3E3E3');
  final textSecondary = hex('808080');
}

Color hex(String hex) {
  final clean = hex.replaceAll('#', '');
  return Color(int.parse('FF$clean', radix: 16));
}
