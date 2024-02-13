import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PremiumScreenItem extends StatelessWidget {
  const PremiumScreenItem({
    super.key,
    required this.text,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 60),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset('assets/premium_item.svg'),
              const SizedBox(width: 10),
              Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF000000),
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
              )
            ],
          ),
          const SizedBox(height: 17),
        ],
      ),
    );
  }
}
