import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:frontend/models/qr_code.dart';

import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({
    super.key,
    required this.qr,
  });
  final QRCodeModel qr;

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
  GlobalKey globalKey = GlobalKey();
  late BannerAd _bannerAd;

  @override
  void initState() {
    super.initState();
    _bannerAd = BannerAd(
      adUnitId: 'ca-app-pub-3940256099942544/2934735716',
      size: AdSize.banner,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          // Ad is loaded
          print('Ad loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          // Ad failed to load
          print('Ad failed to load: $error');
        },
      ),
    );

    // Load the ad
    _bannerAd.load();
  }

  Future<void> shareImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/QR_Code.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareFiles(
        [file.path],
        text: 'Check out my QR code!',
      );
    } catch (e) {
      print('Error sharing image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Color((0xff3CB2E4)),
            weight: 17,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Text(
              'Done',
              style: TextStyle(
                color: Color(
                  (0xff3CB2E4),
                ),
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            RepaintBoundary(
              key: globalKey,
              child: Container(
                width: 398,
                height: 272,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFFFF),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    BarcodeWidget(
                      data: widget.qr.data,
                      barcode: widget.qr.type,
                      width: 236,
                      height: 142,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              width: 398,
              height: 55,
              decoration: BoxDecoration(
                color: const Color(0xFFFFFFFF),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.only(left: 15),
              child: GestureDetector(
                onTap: shareImage,
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.share),
                    SizedBox(width: 10),
                    Text(
                      'Share image',
                      style: TextStyle(
                        color: Color(0xFF000000),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            Container(
              alignment: Alignment.bottomCenter,
              width: _bannerAd.size.width.ceilToDouble(),
              height: _bannerAd.size.height.ceilToDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ],
        ),
      ),
    );
  }
}
