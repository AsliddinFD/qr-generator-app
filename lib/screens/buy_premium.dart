import 'package:flutter/material.dart';
import 'package:frontend/utils/category_data.dart';
import 'package:frontend/widgets/premium_banner.dart';
import 'package:frontend/widgets/buy_premium_screen_item.dart';

class BuyPremium extends StatefulWidget {
  const BuyPremium({super.key});

  @override
  State<BuyPremium> createState() => _BuyPremiumState();
}

class _BuyPremiumState extends State<BuyPremium> {
  bool yearlySubscription = true;
  bool monthlySubscription = false;
  void selectSubscription(int index) {
    if (index == 1) {
      setState(() {
        yearlySubscription = true;
        monthlySubscription = false;
      });
    } else if (index == 2) {
      setState(() {
        yearlySubscription = false;
        monthlySubscription = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const PremiumBanner(),
          const SizedBox(height: 25),
          const Text(
            'Unlimited access \n to all features',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color(0xFF000000),
              fontSize: 24,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 20),
          for (var i in premiumItems) PremiumScreenItem(text: i),
          const SizedBox(height: 50),
          GestureDetector(
            onTap: () {
              selectSubscription(1);
            },
            child: Container(
              width: 398,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: yearlySubscription
                      ? const Color(0xFF3CB2E4)
                      : const Color(0xFFD9D9D9),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '3 Days Free\n',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'after US\$39.99/year',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 31,
                    width: 1,
                    color: const Color(0xFFD9D9D9),
                  ),
                  const Text(
                    'US\$3.33/month',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
          GestureDetector(
            onTap: () {
              selectSubscription(2);
            },
            child: Container(
              width: 398,
              height: 70,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  width: 2,
                  color: monthlySubscription
                      ? const Color(0xFF3CB2E4)
                      : const Color(0xFFD9D9D9),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RichText(
                    text: const TextSpan(
                      children: [
                        TextSpan(
                          text: '3 Days Free\n',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                        TextSpan(
                          text: 'after US\$39.99/month',
                          style: TextStyle(
                            color: Color(0xFF000000),
                            fontWeight: FontWeight.w700,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 31,
                    width: 1,
                    color: const Color(0xFFD9D9D9),
                  ),
                  const Text(
                    'US\$9.99/month',
                    style: TextStyle(
                      color: Color(0xFF000000),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 15),
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
              'Continue',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Color(0xFFFFFFFF),
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 15),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                'Terms of use',
                style: TextStyle(
                  color: Color(0xFFA5A5A5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFFA5A5A5),
                ),
              ),
              Text(
                'Privacy Policy',
                style: TextStyle(
                  color: Color(0xFFA5A5A5),
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  decoration: TextDecoration.underline,
                  decorationColor: Color(0xFFA5A5A5),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
