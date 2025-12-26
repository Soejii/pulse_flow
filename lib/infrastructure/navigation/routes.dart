class Routes {
  static Future<String> get initialRoute async {
    return INSTRUCTION;
  }

  static const GAME = '/game';
  static const HOME = '/home';
  static const INSTRUCTION = '/instruction';
  static const BOTTOM_NAVIGATION = '/bottom-navigation';
}
