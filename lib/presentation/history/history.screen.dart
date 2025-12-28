import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/history.controller.dart';

class HistoryScreen extends GetView<HistoryController> {
  const HistoryScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HistoryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HistoryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
