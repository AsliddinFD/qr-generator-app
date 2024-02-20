import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PremiumBanner extends StatelessWidget {
  const PremiumBanner({
    super.key,
    required this.height,
  });
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 430,
      height: height,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(
            'assets/buy_premium_screen.png',
          ),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 130,
          right: 20,
        ),
        child: Row(
          children: [
            IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(CupertinoIcons.xmark),
            ),
            const Spacer(),
            GestureDetector(
              child: const Text(
                'Restore',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  color: Color(0xFF3CB2E4),
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
