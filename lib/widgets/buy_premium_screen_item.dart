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
              Flexible(
                child: Text(
                  text,
                  maxLines: 2,
                  softWrap: true,
                  style: const TextStyle(
                    color: Color(0xFF000000),
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
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
