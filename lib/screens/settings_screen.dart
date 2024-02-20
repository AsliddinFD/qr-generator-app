import 'package:flutter/material.dart';
import 'package:frontend/screens/buy_premium.dart';
import 'package:frontend/utils/settings_item_data.dart';
import 'package:frontend/widgets/settings_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool sound;
  late bool vibrate;
  @override
  void initState() {
    getPref();
    super.initState();
  }

  getPref() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sound = prefs.getBool('sound') ?? false;
      vibrate = prefs.getBool('vibrate') ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(
            fontFamily: 'SFProDisplay',
            color: Color(0xFF080808),
            fontSize: 22,
            fontWeight: FontWeight.w700,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: Size(MediaQuery.of(context).size.width, 120),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const BuyPremium(),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Image.asset('assets/premium_banner.png'),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 17, left: 20, right: 10),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 702,
          decoration: BoxDecoration(
              color: const Color(0xFFFFFFFF),
              borderRadius: BorderRadius.circular(16)),
          child: ListView.builder(
            itemCount: settingsData.length,
            itemBuilder: (context, index) => GestureDetector(
              onTap: settingsData[index]['name'].contains('color')
                  ? () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BuyPremium(),
                        ),
                      );
                    }
                  : () {},
              child: SettingItem(
                leading: settingsData[index]['leading']!,
                name: settingsData[index]['name']!,
                action: settingsData[index]['action']!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
