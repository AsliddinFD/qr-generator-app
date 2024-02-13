import 'package:flutter_riverpod/flutter_riverpod.dart';

class BottomSheetStateNotifier extends StateNotifier<bool> {
  BottomSheetStateNotifier() : super(false);

  toggleState() {
    state = !state;
  }
}

final bottomSheetProvider =
    StateNotifierProvider<BottomSheetStateNotifier, bool>(
  (ref) => BottomSheetStateNotifier(),
);
