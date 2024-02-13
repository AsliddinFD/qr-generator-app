import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/utils/functions.dart';
import 'package:frontend/utils/category_data.dart';
import 'package:frontend/widgets/category_card.dart';

class AddQrCodeCategories extends StatefulWidget {
  const AddQrCodeCategories({super.key});

  @override
  State<AddQrCodeCategories> createState() => _AddQrCodeCategoriesState();
}

class _AddQrCodeCategoriesState extends State<AddQrCodeCategories>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      lowerBound: 0,
      upperBound: 1,
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
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
            weight: 16,
            color: Color(0xFF3CB2E4),
          ),
        ),
        title: const Text(
          'Creat QR Code',
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            color: Color(0xFF080808),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) => SlideTransition(
          position: Tween(
            begin: const Offset(0, 0.3),
            end: const Offset(0, 0),
          ).animate(_animationController),
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: SizedBox(
              width: 400,
              child: GridView.builder(
                itemCount: categories.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 2,
                ),
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    showModal(
                      categories[index],
                      context,
                    );
                  },
                  child: CategoryCard(
                    category: categories[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
