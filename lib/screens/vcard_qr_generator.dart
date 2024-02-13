import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/widgets/category_card.dart';
import 'package:frontend/screens/created_qr_code_view.dart';

class VcardQrGenerator extends StatefulWidget {
  const VcardQrGenerator({
    super.key,
    required this.category,
  });
  final Map<String, dynamic> category;

  @override
  State<VcardQrGenerator> createState() => _VcardQrGeneratorState();
}

class _VcardQrGeneratorState extends State<VcardQrGenerator> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _phone = '';
  String _email = '';
  String _address = '';
  bool _isLoading = false;

  String generateVCardData(
    String name,
    String email,
    String phoneNumber,
    String address,
  ) {
    return 'BEGIN:VCARD\n'
        'VERSION:3.0\n'
        'FN:$name\n'
        'TEL:$phoneNumber\n'
        'EMAIL:$email\n'
        'ADR:$address\n'
        'END:VCARD';
  }

  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    final vcard = generateVCardData(
      _name,
      _email,
      _phone,
      _address,
    );
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => QRCodeView(data: vcard),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isKeyboard = MediaQuery.of(context).viewInsets.bottom != 0;
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 15),
            if (!isKeyboard) CategoryCard(category: widget.category),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Please enter a name*',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xFF7B7B7B),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Name',
                    ),
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
                  const Text(
                    'Please enter a phone number*',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xFF7B7B7B),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Phone',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _phone = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter an email',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xFF7B7B7B),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Email',
                    ),
                    onSaved: (value) {
                      _email = value!;
                    },
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Please enter an address',
                    style: TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xFF7B7B7B),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'Address',
                    ),
                    onSaved: (value) {
                      _address = value!;
                    },
                  ),
                  const SizedBox(height: 10),
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
