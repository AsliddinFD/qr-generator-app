import 'package:barcode/barcode.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/buy_premium.dart';
import 'package:frontend/screens/qr_generator.dart';
import 'package:frontend/screens/vcard_qr_generator.dart';
import 'package:frontend/screens/wifi_qr_code_generator.dart';
import 'package:intl/intl.dart';
import 'package:fl_mlkit_scanning/fl_mlkit_scanning.dart' as flkit;
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;

void showModal(category, context) {
  if (category['name'].contains('WIFI')) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) => WifiQrCodeGenerator(
        category: category,
      ),
    );
  } else if (category['name'].contains('Card')) {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) => VcardQrGenerator(
        category: category,
      ),
    );
  } else {
    showModalBottomSheet(
      isScrollControlled: true,
      useSafeArea: true,
      clipBehavior: Clip.hardEdge,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      context: context,
      builder: (context) => QrGenerator(
        category: category,
      ),
    );
  }
}

String generateQRData(String type, String data) {
  switch (type.toLowerCase()) {
    case 'Phone':
      return 'tel:$data';
    case 'Email':
      return 'mailto:$data';
    case 'URL':
      return data.startsWith('http') ? data : 'https://$data';
    case 'Text':
      return data;
    case 'App Store':
      return 'https://apps.apple.com/us/app/$data';
    case 'Twitter':
      return 'https://twitter.com/$data';
    case 'Facebook':
      return 'https://www.facebook.com/$data';
    case 'Whatsapp':
      return 'https://wa.me/$data';
    case 'Instagram':
      return 'https://www.instagram.com/$data';
    case 'YouTube':
      return 'https://www.youtube.com/$data';
    case 'Google Drive':
      return 'https://drive.google.com/$data';
    case 'Dropbox':
      return 'https://www.dropbox.com/$data';
    default:
      return data;
  }
}

String formatDate(DateTime date) {
  var formatter = DateFormat('yyyy-MM-dd, HH:mm');
  String formattedDate = formatter.format(date);
  return formattedDate;
}

Barcode convertBarcode(
  qr.BarcodeFormat? cameraBarcodeType,
  flkit.BarcodeFormat? imageBarcodeType,
) {
  if (cameraBarcodeType != null) {
    switch (cameraBarcodeType) {
      case qr.BarcodeFormat.code128:
        return Barcode.code128();
      case qr.BarcodeFormat.qrcode:
        return Barcode.qrCode();
      case qr.BarcodeFormat.code39:
        return Barcode.code39();
      case qr.BarcodeFormat.code93:
        return Barcode.code93();
      case qr.BarcodeFormat.ean8:
        return Barcode.ean8();
      case qr.BarcodeFormat.ean13:
        return Barcode.ean13();
      case qr.BarcodeFormat.pdf417:
        return Barcode.pdf417();
      case qr.BarcodeFormat.aztec:
        return Barcode.aztec();
      case qr.BarcodeFormat.itf:
        return Barcode.itf();
      case qr.BarcodeFormat.upcA:
        return Barcode.upcA();
      case qr.BarcodeFormat.upcE:
        return Barcode.upcE();
      case qr.BarcodeFormat.codabar:
        return Barcode.codabar();
      case qr.BarcodeFormat.dataMatrix:
        return Barcode.dataMatrix();
      default:
        throw Exception("Unsupported camera barcode type: $cameraBarcodeType");
    }
  } else if (imageBarcodeType != null) {
    switch (imageBarcodeType) {
      case flkit.BarcodeFormat.code128:
        return Barcode.code128();
      case flkit.BarcodeFormat.qrCode:
        return Barcode.qrCode();
      case flkit.BarcodeFormat.aztec:
        return Barcode.aztec();
      case flkit.BarcodeFormat.dataMatrix:
        return Barcode.dataMatrix();
      case flkit.BarcodeFormat.code39:
        return Barcode.code39();
      case flkit.BarcodeFormat.code93:
        return Barcode.code93();
      case flkit.BarcodeFormat.codaBar:
        return Barcode.codabar();
      case flkit.BarcodeFormat.ean8:
        return Barcode.ean8();
      case flkit.BarcodeFormat.ean13:
        return Barcode.ean13();
      case flkit.BarcodeFormat.itf:
        return Barcode.itf();
      case flkit.BarcodeFormat.pdf417:
        return Barcode.pdf417();
      case flkit.BarcodeFormat.upcA:
        return Barcode.upcA();
      case flkit.BarcodeFormat.upcE:
        return Barcode.upcE();
      default:
        throw Exception("Unsupported image barcode type: $imageBarcodeType");
    }
  }

  throw Exception("No barcode type provided.");
}
