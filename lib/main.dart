import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pulse_flow/infrastructure/navigation/routes.dart';
import 'package:pulse_flow/shared/audio/audio_service.dart';
import 'package:pulse_flow/shared/progress/progress_controller.dart';

import 'infrastructure/navigation/navigation.dart';

void main() async {
  Get.put(ProgressController(), permanent: true);
  final audio = AudioService();
  await audio.init();
  Get.put(audio, permanent: true);
  runApp(Main());
}

class Main extends StatelessWidget {
  const Main({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Focus Pulse',
      debugShowCheckedModeBanner: false,
      initialRoute: Routes.GATE,
      getPages: Nav.routes,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorScheme: const ColorScheme.dark(
          surface: Color(0xFF1E1E1E),
        ),
        scaffoldBackgroundColor: const Color(0xFF121212),
      ),
    );
  }
}
