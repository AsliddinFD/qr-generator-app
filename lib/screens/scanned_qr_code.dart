import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/models/qr_code.dart';
import 'package:frontend/screens/show_image_screen.dart';
import 'package:frontend/utils/functions.dart';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannedBarcode extends StatefulWidget {
  const ScannedBarcode({
    super.key,
    required this.qrcode,
  });
  final QRCodeModel qrcode;

  @override
  State<ScannedBarcode> createState() => _ScannedBarcodeState();
}

class _ScannedBarcodeState extends State<ScannedBarcode> {
  GlobalKey barcodeKey = GlobalKey();
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

  @override
  Widget build(BuildContext context) {
    final date = formatDate(widget.qrcode.date);
    final data = widget.qrcode.data;
    final category = widget.qrcode.category;

    void navigateToWebsite(String searchData) async {
      String encodedSearchData = Uri.encodeComponent(searchData);
      var url = Uri.parse('https://www.google.com/search?q=$encodedSearchData');
      if (await canLaunchUrl(url)) {
        await launchUrl(url);
      } else {
        throw 'Could not launch $url';
      }
    }

    shareBarcodeImage() {
      Share.share(widget.qrcode.data);
    }

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
          IconButton(
            onPressed: shareBarcodeImage,
            icon: const Icon(
              Icons.ios_share_sharp,
              weight: 17,
            ),
            color: const Color((0xff3CB2E4)),
          ),
          GestureDetector(
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
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            const SizedBox(height: 20),
            Container(
              width: 398,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFFFFFFF),
              ),
              child: Padding(
                padding: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$category: $date',
                      style: const TextStyle(
                        color: Color(0xFF787878),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Barcode',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF000000),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      data,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Color(0xFF000000),
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 35),
            const Text(
              'SEARCH OPTIONS',
              style: TextStyle(
                color: Color(0xFF787878),
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: 398,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFFFFFFF),
              ),
              padding: const EdgeInsets.all(13),
              child: GestureDetector(
                onTap: () {
                  navigateToWebsite(data);
                },
                child: const Row(
                  children: [
                    Icon(CupertinoIcons.search),
                    SizedBox(width: 10),
                    Text(
                      'Google.com',
                      style: TextStyle(
                        color: Color((0xFF000000)),
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              width: 398,
              height: 50,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: const Color(0xFFFFFFFF),
              ),
              padding: const EdgeInsets.all(13),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ShowImage(
                        qr: widget.qrcode,
                      ),
                    ),
                  );
                },
                child: Row(
                  children: [
                    SvgPicture.asset(
                      widget.qrcode.type != null &&
                              widget.qrcode.type == Barcode.qrCode()
                          ? 'assets/qr_icon.svg'
                          : 'assets/barcode_icon.svg',
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                    const Text(
                      'Show image',
                      style: TextStyle(
                        color: Color((0xFF000000)),
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
              width: _bannerAd.size.width.floorToDouble(),
              height: _bannerAd.size.height.floorToDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ],
        ),
      ),
    );
  }
}
