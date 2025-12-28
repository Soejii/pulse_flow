import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:pulse_flow/shared/audio/audio_service.dart';
import 'package:pulse_flow/shared/progress/progress_controller.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  var initialRoute = Routes.GATE;
  Get.put(ProgressController(), permanent: true);
  final audio = AudioService();
  await audio.init();
  Get.put(audio, permanent: true);
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  const Main(this.initialRoute, {super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Focus Pulse',
      debugShowCheckedModeBanner: false,
      initialRoute: initialRoute,
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
