import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/screens/created_qr_code_view.dart';
import 'package:frontend/utils/functions.dart';
import 'package:frontend/widgets/category_card.dart';

class QrGenerator extends StatefulWidget {
  const QrGenerator({super.key, required this.category});
  final Map<String, dynamic> category;
  @override
  State<QrGenerator> createState() => _QrGeneratorState();
}

class _QrGeneratorState extends State<QrGenerator> {
  final _formKey = GlobalKey<FormState>();
  String _value = '';
  bool _isLoading = false;
  void _save() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => QRCodeView(
            data: generateQRData(
              widget.category['name'],
              _value,
            ),
          ),
        ),
      );
      setState(() {
        _isLoading = false;
      });
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
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 15),
            CategoryCard(category: widget.category),
            const SizedBox(height: 10),
            const SizedBox(height: 10),
            Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.category['label'],
                    style: const TextStyle(
                      fontFamily: 'SFProDisplay',
                      color: Color(0xFF7B7B7B),
                      fontWeight: FontWeight.w400,
                      fontSize: 16,
                    ),
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: widget.category['placeholder'],
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "This field cannot be empty";
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _value = value!;
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
