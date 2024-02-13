import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsStateNotifier extends StateNotifier {
  PrefsStateNotifier() : super(dynamic);
  SharedPreferences? _prefs;
  late bool sound;
  late bool vibrate;

  Future<void> getPref() async {
    _prefs = await SharedPreferences.getInstance();
    sound = _prefs!.getBool('sound') ?? true;
    vibrate = _prefs!.getBool('vibrate') ?? true;
    print(sound);
    print(vibrate);
  }
}

final prefsProvider = StateNotifierProvider<PrefsStateNotifier, dynamic>(
  (ref) => PrefsStateNotifier(),
);
