import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/providers/bottom_sheet_provider.dart';
import 'package:frontend/screens/add_qrcode_category.dart';
import 'package:frontend/widgets/toggle_bar.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({
    super.key,
  });

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String chosenCodes = 'Scanned';
  void selectSetting(String setting) {
    setState(() {
      chosenCodes = setting;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                !ref.watch(bottomSheetProvider)
                    ? Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddQrCodeCategories(),
                        ),
                      )
                    : null;
              },
              child: Text(
                !ref.watch(bottomSheetProvider) ? 'Create' : 'All',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff3CB2E4),
                ),
              ),
            ),
            const Text(
              'History',
              style: TextStyle(
                fontFamily: 'SFProDisplay',
                color: Color(0xFF080808),
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            GestureDetector(
              onTap: () {
                ref.watch(bottomSheetProvider)
                    ? ref.watch(bottomSheetProvider.notifier).toggleState()
                    : ref.watch(bottomSheetProvider.notifier).toggleState();
              },
              child: Text(
                !ref.watch(bottomSheetProvider) ? 'Edit' : 'Done',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Color(0xff3CB2E4),
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 120),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Image.asset('assets/premium_banner.png'),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
        child: ListView(children: [
          WifiToggleSwitch(
            selectSetting: selectSetting,
            labels: const ['Scanned', 'Created'],
          )
        ]),
      ),
      bottomNavigationBar: Visibility(
        visible: ref.watch(bottomSheetProvider),
        child: Container(
          height: 111,
          child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/history_share_icon.svg'),
                label: 'Share',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/history_export_icon.svg'),
                label: 'Export',
              ),
              BottomNavigationBarItem(
                icon: SvgPicture.asset('assets/history_delete_icon.svg'),
                label: 'Delete',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
