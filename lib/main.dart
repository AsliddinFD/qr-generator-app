import 'package:flutter/material.dart';
import 'package:frontend/screens/add_qrcode_category.dart';
import 'package:frontend/screens/buy_premium.dart';
import 'package:frontend/screens/tabs.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await MobileAds.instance.initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: const Color(0xFFF4FCFC),
          inputDecorationTheme: const InputDecorationTheme(
            hintStyle: TextStyle(
              fontFamily: 'SFProDisplay',
              color: Color(0xFF7B7B7B),
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: Color(0xFFE4E4E4),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: Color(0xFFE4E4E4),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              borderSide: BorderSide(
                color: Color(0xFFE4E4E4),
              ),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFFF4FCFC),
          ),
        ),
        home: const TabsScreen(),
      ),
    );
  }
}
