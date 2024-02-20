import 'package:flutter/material.dart';
import 'package:frontend/screens/buy_premium.dart';
import 'package:frontend/widgets/qr_code_card.dart';
import 'package:frontend/data/created_qr_codes.dart';
import 'package:frontend/screens/add_qrcode_category.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class CreateQrCode extends StatefulWidget {
  const CreateQrCode({super.key});

  @override
  State<CreateQrCode> createState() => _CreateQrCodeState();
}

class _CreateQrCodeState extends State<CreateQrCode> {
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
          debugPrint('Ad loaded');
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          debugPrint('Ad failed to load: $error');
        },
      ),
    );

    _bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddQrCodeCategories(),
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 28,
                color: Color(0xFF3CB2E4),
              ),
            ),
            const Text(
              'Creat QR Code',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Color(0xFF080808),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            Container(width: 50)
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(
            MediaQuery.of(context).size.width,
            120,
          ),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BuyPremium(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Image.asset('assets/premium_banner.png'),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 30),
            qrCodes.isEmpty
                ? const SizedBox(
                    width: double.infinity,
                    child: Text(
                      textAlign: TextAlign.center,
                      'The history of QR code \n creation is empty',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8D8D8D),
                      ),
                    ),
                  )
                : Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => QRCodeCard(
                        qrCode: qrCodes[index],
                      ),
                    ),
                  ),
            const Spacer(),
            Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              height: _bannerAd.size.height.ceilToDouble(),
              child: AdWidget(ad: _bannerAd),
            ),
          ],
        ),
      ),
    );
  }
}
