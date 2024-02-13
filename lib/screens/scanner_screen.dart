import 'dart:io';
import 'package:fl_mlkit_scanning/fl_mlkit_scanning.dart' as flkit;
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:frontend/models/qr_code.dart';
import 'package:frontend/screens/scanned_qr_code.dart';
import 'package:frontend/utils/functions.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:image_picker/image_picker.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart' as qr;
import 'package:qr_scanner_overlay/qr_scanner_overlay.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vibration/vibration.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScanScreen extends ConsumerStatefulWidget {
  const ScanScreen({super.key});

  @override
  ConsumerState<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends ConsumerState<ScanScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  late qr.QRViewController controller;
  late bool sound;
  late bool vibrate;
  bool isNavigating = false;

  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  void getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sound = prefs.getBool('sound')!;
      vibrate = prefs.getBool('vibrate')!;
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _getImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile != null && context.mounted) {
      final File file = File(pickedFile.path!);
      final call = flkit.FlMlKitScanningController();
      await call.setBarcodeFormat([flkit.BarcodeFormat.all]);
      final rest = await call.scanningImageByte(file.readAsBytesSync());
      final data = rest!.barcodes![0].value;
      final type = rest.barcodes![0].format;
      if (rest != null && context.mounted) {
        final qrcode = QRCodeModel(
          data: data!,
          type: convertBarcode(null, type),
          category: 'Scanned',
          date: DateTime.now(),
        );
        playSoundEffect();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ScannedBarcode(
              qrcode: qrcode,
            ),
          ),
        );
      }
    }
  }

  void playSoundEffect() {
    if (sound && vibrate) {
      final player = AudioPlayer();
      player.play(
        AssetSource('Barcode-scanner-beep-sound.mp3'),
        volume: 0.4,
        balance: 0.5,
        ctx: const AudioContext(
          iOS: AudioContextIOS(),
        ),
      );
      Vibration.vibrate();
    } else if (sound && !vibrate) {
      final player = AudioPlayer();
      player.play(
        AssetSource('Barcode-scanner-beep-sound.mp3'),
        volume: 0.4,
        balance: 0.5,
        ctx: const AudioContext(
          iOS: AudioContextIOS(),
        ),
      );
    } else if (!sound && vibrate) {
      Vibration.vibrate();
    } else {
      return;
    }
  }

  void _onQRViewCreated(qr.QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) async {
      final qrcode = QRCodeModel(
        data: scanData.code!,
        category: 'Scanned',
        date: DateTime.now(),
        type: convertBarcode(scanData.format, null),
      );
      if (!isNavigating) {
        isNavigating = true;
        controller.pauseCamera();
        playSoundEffect();
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ScannedBarcode(
              qrcode: qrcode,
            ),
          ),
        );
        controller.resumeCamera();
        isNavigating = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          qr.QRView(
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          ),
          QRScannerOverlay(),
          Positioned(
              top: 75,
              left: 20,
              child: GestureDetector(
                onTap: () {
                  controller.toggleFlash();
                },
                child: SvgPicture.asset(
                  'assets/flashlight_icon.svg',
                  width: 48,
                  height: 48,
                ),
              )),
          Positioned(
            top: 75,
            right: 20,
            child: GestureDetector(
              onTap: () {
                _getImage();
              },
              child: SvgPicture.asset(
                'assets/pick_image_icon.svg',
                width: 48,
                height: 48,
              ),
            ),
          )
        ],
      ),
    );
  }
}
