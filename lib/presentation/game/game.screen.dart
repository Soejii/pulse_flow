import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/game.controller.dart';

class GameScreen extends GetView<GameController> {
  const GameScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GameScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GameScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
