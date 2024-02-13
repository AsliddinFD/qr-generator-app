import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class VibrateNotifier extends StateNotifier<bool> {
  VibrateNotifier() : super(true);

  toggleVibrate() async {
    state = !state;
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('vibrate', state);
  }
}

final vibrateProvider = StateNotifierProvider<VibrateNotifier, bool>(
  (ref) => VibrateNotifier(),
);
