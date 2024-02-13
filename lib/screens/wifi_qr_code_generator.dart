import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/created_qr_code_view.dart';
import 'package:frontend/widgets/category_card.dart';
import 'package:frontend/widgets/toggle_bar.dart';

class WifiQrCodeGenerator extends StatefulWidget {
  const WifiQrCodeGenerator({
    super.key,
    required this.category,
  });
  final Map<String, dynamic> category;
  @override
  State<WifiQrCodeGenerator> createState() => _WifiQrCodeGeneratorState();
}

class _WifiQrCodeGeneratorState extends State<WifiQrCodeGenerator> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _password = '';
  bool _isLoading = false;
  String selectedWifi = 'Free';
  
  void selectWifiSetting(String setting) {
    setState(() {
      selectedWifi = setting;
    });
  }

  void _save() {
    if (selectedWifi == 'Free') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isLoading = true;
        });
        String freeWifiData = 'WIFI:S:$_name;';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRCodeView(data: freeWifiData),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    } else if (selectedWifi == 'Secured') {
      if (_formKey.currentState!.validate()) {
        _formKey.currentState!.save();
        setState(() {
          _isLoading = true;
        });
        String securedWifiData = 'WIFI:S:$_name;T:WPA;P:$_password;;';
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => QRCodeView(data: securedWifiData),
          ),
        );
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(CupertinoIcons.xmark),
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            WifiToggleSwitch(
              selectSetting: selectWifiSetting,
              labels: const ['Free', 'Secured'],
            ),
            const SizedBox(height: 15),
            CategoryCard(category: widget.category),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please enter a wifi name',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xFF7B7B7B),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(hintText: 'Network'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _name = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  selectedWifi == 'Secured'
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Please enter a wifi password',
                              style: TextStyle(
                                fontFamily: 'SFProDisplay',
                                color: Color(0xFF7B7B7B),
                                fontWeight: FontWeight.w400,
                                fontSize: 16,
                              ),
                            ),
                            TextFormField(
                              decoration:
                                  const InputDecoration(hintText: 'Password'),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "This field cannot be empty";
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _password = value!;
                              },
                            )
                          ],
                        )
                      : Container()
                ],
              ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isLoading ? null : _save,
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(398, 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: const Color(0xFF3CB2E4),
              ),
              child: _isLoading
                  ? const SizedBox(
                      child: CircularProgressIndicator(),
                    )
                  : const Text(
                      'Create',
                      style: TextStyle(
                        fontFamily: 'SFProDisplay',
                        color: Color(0xFFFFFFFF),
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
