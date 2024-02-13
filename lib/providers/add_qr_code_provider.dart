import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:frontend/data/created_qr_codes.dart';
import 'package:frontend/models/qr_code.dart';

class AddQrStateNotifier extends StateNotifier {
  AddQrStateNotifier() : super(dynamic);

  void addQr(QRCodeModel qr) {
    if (qrCodes.contains(qr)) {
      qrCodes.remove(qr);
      qrCodes.add(qr);
    } else {
      qrCodes.add(qr);
    }
  }
}

final addQrProvider = StateNotifierProvider<AddQrStateNotifier, dynamic>(
  (ref) => AddQrStateNotifier(),
);
