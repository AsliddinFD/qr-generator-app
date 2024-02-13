import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:frontend/providers/sound_provider.dart';
import 'package:frontend/providers/vibrate_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingItem extends ConsumerStatefulWidget {
  const SettingItem({
    super.key,
    required this.leading,
    required this.name,
    required this.action,
  });

  final String leading;
  final String name;
  final String action;

  @override
  ConsumerState<SettingItem> createState() => _SettingItemState();
}

class _SettingItemState extends ConsumerState<SettingItem> {
  bool sound = true;
  bool vibrate = true;
  @override
  void initState() {
    super.initState();
    getPrefs();
  }

  getPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      sound = prefs.getBool('sound')!;
      vibrate = prefs.getBool('vibrate')!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          leading: SvgPicture.asset(
            widget.leading,
            width: 20,
            height: 20,
          ),
          title: Text(
            widget.name,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w400,
              color: Color(0xff080808),
            ),
          ),
          trailing: widget.action == ''
              ? Platform.isIOS
                  ? CupertinoSwitch(
                      activeColor: const Color(0xff3CB2E4),
                      value: widget.name.contains('Sound') ? sound : vibrate,
                      onChanged: (value) {
                        setState(() {
                          widget.name.contains('Sound')
                              ? ref.read(soundProvider.notifier).toggleSound()
                              : ref
                                  .read(vibrateProvider.notifier)
                                  .toggleVibrate();
                        });
                        getPrefs();
                      },
                    )
                  : Switch(
                      activeColor: const Color(0xff3CB2E4),
                      value: widget.name.contains('Sound') ? sound : vibrate,
                      onChanged: (value) {
                        setState(() {
                          widget.name.contains('Sound')
                              ? ref.read(soundProvider.notifier).toggleSound()
                              : ref
                                  .read(vibrateProvider.notifier)
                                  .toggleVibrate();
                        });
                        getPrefs();
                      },
                    )
              : SvgPicture.asset(widget.action),
        )
      ],
    );
  }
}
