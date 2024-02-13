import 'package:flutter/material.dart';

class WifiToggleSwitch extends StatefulWidget {
  const WifiToggleSwitch({
    super.key,
    required this.selectSetting,
    required this.labels,
  });
  final void Function(String) selectSetting;
  final List<String> labels;
  @override
  State<WifiToggleSwitch> createState() => _WifiToggleSwitchState();
}

class _WifiToggleSwitchState extends State<WifiToggleSwitch>
    with SingleTickerProviderStateMixin {
  late TabController tabBarController;

  @override
  void initState() {
    tabBarController = TabController(length: 2, vsync: this);
    super.initState();
    tabBarController.addListener(() {
      widget.selectSetting(
        widget.labels[tabBarController.index],
      );
    });
  }

  @override
  void dispose() {
    tabBarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 397,
      height: 50,
      padding: const EdgeInsets.all(1.5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: const Color(0xFFFFFFFF)),
      clipBehavior: Clip.hardEdge,
      child: TabBar(
        overlayColor: MaterialStateProperty.all(Colors.transparent),
        dividerColor: Colors.transparent,
        unselectedLabelColor: const Color(0xff989898),
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: const Color(0xFF3CB2E4),
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        labelStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        labelColor: const Color(0xFFFFFFFF),
        controller: tabBarController,
        splashBorderRadius: BorderRadius.circular(12),
        tabs: widget.labels
            .map(
              (item) => Tab(
                text: item,
              ),
            )
            .toList(),
      ),
    );
  }
}
