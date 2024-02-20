import 'package:flutter_riverpod/flutter_riverpod.dart';

class ActiveScreenStateNotifier extends StateNotifier<int> {
  ActiveScreenStateNotifier() : super(0);

  void setActiveScreen(int index) => state = index;
}

final activeScreenProvider =
    StateNotifierProvider<ActiveScreenStateNotifier, int>(
  (ref) => ActiveScreenStateNotifier(),
);
