import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:frontend/utils/functions.dart';

List<Map<String, dynamic>> settingsData = [
  {
    'leading': 'assets/settings_backcolor_icon.svg',
    'name': 'Background color',
    'action': 'assets/setting_arrow.svg',
  },
  {
    'leading': 'assets/settings_codecolor_icon.svg',
    'name': 'Code color',
    'action': 'assets/setting_arrow.svg',
  },
  {
    'leading': 'assets/settings_restore.svg',
    'name': 'Restore',
    'action': 'assets/setting_arrow.svg',
  },
  {
    'leading': 'assets/settings_voice.svg',
    'name': 'Sound',
    'action': '',
  },
  {
    'leading': 'assets/settings_vibrate.svg',
    'name': 'Vibrate',
    'action': '',
  },
  {
    'leading': 'assets/settings_contact.svg',
    'name': 'Contact Us',
    'action': 'assets/setting_arrow.svg',
  },
  {
    'leading': 'assets/settings_rate.svg',
    'name': 'Rate Us',
    'action': 'assets/setting_arrow.svg',
  },
  {
    'leading': 'assets/settings_share.svg',
    'name': 'Share Us',
    'action': 'assets/setting_arrow.svg',
  },
  {
    'leading': 'assets/settings_terms.svg',
    'name': 'Terms and Use',
    'action': 'assets/setting_arrow.svg',
  },
  {
    'leading': 'assets/settings_privacy.svg',
    'name': 'Privacy Policy',
    'action': 'assets/setting_arrow.svg',
  },
];
