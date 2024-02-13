import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SplashScreenIntro extends StatefulWidget {
  const SplashScreenIntro({super.key});

  @override
  State<SplashScreenIntro> createState() => _SplashScreenIntroState();
}

class _SplashScreenIntroState extends State<SplashScreenIntro> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/splash_screen_intro.svg',
            ),
            const SizedBox(height: 10),
            const Text(
              'QR Code',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                fontSize: 18.51,
                fontWeight: FontWeight.w700,
                color: Color(0xFF3CB2E4),
              ),
            )
          ],
        ),
      ),
    );
  }
}
