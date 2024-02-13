import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    super.key,
    required this.category,
  });
  final Map<String, dynamic> category;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 122,
      height: 90,
      child: Stack(
        fit: StackFit.loose,
        children: [
          Container(
            width: 122,
            height: 90,
            decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  category['icon'],
                  width: 30,
                  height: 30,
                ),
                const SizedBox(height: 8),
                Text(
                  category['name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontFamily: 'SFProDisplay',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Color(0xFF171717),
                    height: 1.2,
                  ),
                )
              ],
            ),
          ),
          category['premium']
              ? Positioned(
                  top: 10,
                  right: 15,
                  child: Image.asset(
                    'assets/premium_icon.png',
                    width: 29,
                    height: 17,
                  ),
                )
              : Container()
        ],
      ),
    );
  }
}
