import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pulse_flow/infrastructure/navigation/routes.dart';
import 'package:pulse_flow/presentation/screens.dart';

class InstructionController extends GetxController {
  late final PageController pageController;
  var currentPage = 0.obs;

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void goToNextPage() {
    if (currentPage < pages.length - 1) {
      pageController.nextPage(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOut,
      );
    } else {
      finishOnboarding();
    }
  }

  void skip() {
    finishOnboarding();
  }

  void finishOnboarding() {
    Get.offNamed(Routes.HOME);
  }

  final List<InstructionData> pages = const [
    InstructionData(
      title: 'Focus Pulse',
      body:
          'Uji fokus kamu dengan mengingat urutan kotak hijau sambil mengabaikan kotak pengganggu.',
      bullets: [
        'kotak akan muncul satu per satu di layar.',
        'Sebagian kotak menyala hijau, sebagian lagi merah atau biru.',
        'Fokus hanya pada kotak hijau dan urutan kemunculannya.',
      ],
    ),
    InstructionData(
      title: 'Ingat urutan kotak hijau',
      body:
          'Setiap ronde, semua kotak akan muncul sekali. Kamu harus mengingat kotak mana yang hijau dan muncul di urutan ke berapa.',
      bullets: [
        'kotak muncul satu per satu dengan warna.',
        'Catat di kepala kamu kotak mana yang hijau dan urutannya.',
        'Setelah semua selesai, layar akan kosong dan masuk ke fase recall.',
      ],
    ),
    InstructionData(
      title: 'kotak pengganggu',
      body:
          'kotak merah dan biru muncul untuk mengacaukan perhatian kamu. Mereka tidak masuk ke jawaban yang benar.',
      bullets: [
        'kotak merah dan biru adalah distractor atau pengganggu.',
        'Jangan masukkan kotak merah atau biru ke dalam urutan yang kamu ingat.',
        'Saat recall, abaikan ingatan tentang kotak merah dan biru.',
      ],
    ),
    InstructionData(
      title: 'Memulai Permainan',
      body:
          'Untuk memulai permainan, ketuk salah satu kotak setelah skor muncul. Ronde akan langsung dimulai dan warna kotak akan tampil satu per satu.',
      bullets: [
        'Ketuk kotak mana saja untuk memulai ronde baru.',
        'Setelah dimulai, setiap kotak akan muncul sekali dengan warna tertentu.',
        'Perhatikan hijau, karena itu adalah urutan yang harus kamu ingat.',
        'Abaikan kotak merah atau biru yang muncul.',
      ],
    ),
    InstructionData(
      title: 'Fase recall dan hasil',
      body:
          'Setelah semua kotak muncul, warna akan direset. Sekarang kamu harus mengetuk kotak sesuai urutan hijau yang tadi muncul.',
      bullets: [
        'Ketuk kotak sesuai urutan kemunculan kotak hijau.',
        'Jika salah mengetuk, ronde langsung berakhir.',
        'Hasil akan menunjukkan berapa banyak kotak hijau yang berhasil kamu ingat dengan benar.',
      ],
    ),
  ];
}
