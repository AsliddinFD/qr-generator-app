import 'package:flutter/material.dart';

class SplashScreenInfo extends StatelessWidget {
  const SplashScreenInfo({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 70, horizontal: 20),
          child: Column(
            children: [
              SizedBox(
                height: 497,
                child: Stack(
                  children: [
                    Image.asset(
                      'assets/splash_screen_info_background.png',
                      width: 398,
                      height: 497,
                    ),
                    Positioned(
                      bottom: 20,
                      child: Image.asset(
                        'assets/splash_screen_info_overlay.png',
                        width: 397,
                        height: 327,
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'QR code scan',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF000000),
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                textAlign: TextAlign.center,
                'Instantly scan QR codes and barcodes \n or create your own.',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  color: Color(0xFF909090),
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(398, 60),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  backgroundColor: const Color(0xFF3CB2E4),
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontFamily: 'SFProDisplay',
                    color: Color(0xFFFFFFFF),
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 15),
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  children: [
                    TextSpan(
                      text: 'By clicking on the continue button you agree to \n ',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFAFAFAF),
                      ),
                    ),
                    TextSpan(
                      text: 'the privacy policy ',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF3CB2E4),
                      ),
                    ),
                    TextSpan(
                      text: 'and ',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFFAFAFAF),
                      ),
                    ),
                    TextSpan(
                      text: 'user agreement ',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Color(0xFF3CB2E4),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
