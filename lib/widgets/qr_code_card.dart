import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:frontend/models/qr_code.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QRCodeCard extends StatelessWidget {
  const QRCodeCard({
    super.key,
    required this.qrCode,
  });
  final QRCodeModel qrCode;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          CustomPaint(
            size: const Size(39.65, 39.65),
            painter: QrPainter(
              data: qrCode.data,
              version: QrVersions.auto,
            ),
          ),
          const SizedBox(width: 20),
          Column(
            children: [
              const Text(
                'Product',
                style: TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 18.51,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                qrCode.data.toString(),
                style: const TextStyle(
                  fontFamily: 'SFProDisplay',
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              )
            ],
          ),
          const Spacer(),
          SvgPicture.asset('assets/download.svg', width: 18, height: 20),
          SvgPicture.asset('assets/delete.svg', width: 18, height: 20),
        ],
      ),
    );
  }
}
