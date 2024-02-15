import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/providers/bottom_sheet_provider.dart';
import 'package:frontend/screens/history_screen.dart';
import 'package:frontend/screens/create_qr.dart';
import 'package:frontend/screens/scanner_screen.dart';
import 'package:frontend/screens/settings_screen.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int currentIndex = 0;
  void selectTab(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void updateActiveScreen(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen = const CreateQrCode();
    if (currentIndex == 0) {
      activeScreen = ScanScreen(updateActiveScreen: updateActiveScreen,);
    } else if (currentIndex == 1) {
      activeScreen = const CreateQrCode();
    } else if (currentIndex == 2) {
      activeScreen = HistoryScreen(
        updateActiveScreen: updateActiveScreen,
      );
    } else if (currentIndex == 3) {
      activeScreen = const SettingsScreen();
    }
    return Scaffold(
      body: activeScreen,
      bottomNavigationBar: Visibility(
        visible: !ref.watch(bottomSheetProvider),
        child: SizedBox(
          height: 105,
          child: BottomNavigationBar(
            onTap: selectTab,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            showSelectedLabels: false,
            selectedLabelStyle: const TextStyle(fontSize: 1),
            unselectedFontSize: 1,
            items: [
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    currentIndex == 0
                        ? const Color(0xff3CB2E4)
                        : const Color(0xff989898),
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/scan_tab.svg'),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    currentIndex == 1
                        ? const Color(0xff3CB2E4)
                        : const Color(0xff989898),
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/create_tab.svg'),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    currentIndex == 2
                        ? const Color(0xff3CB2E4)
                        : const Color(0xff989898),
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/history_tab.svg'),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: ColorFiltered(
                  colorFilter: ColorFilter.mode(
                    currentIndex == 3
                        ? const Color(0xff3CB2E4)
                        : const Color(0xff989898),
                    BlendMode.srcIn,
                  ),
                  child: SvgPicture.asset('assets/settings_tab.svg'),
                ),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
