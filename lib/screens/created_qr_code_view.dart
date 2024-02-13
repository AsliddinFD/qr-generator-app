import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';

class QRCodeView extends StatefulWidget {
  const QRCodeView({
    super.key,
    required this.data,
  });
  final String data;
  @override
  State<QRCodeView> createState() => _QRCodeViewState();
}

class _QRCodeViewState extends State<QRCodeView> {
  GlobalKey globalKey = GlobalKey();

  Future<void> shareImage() async {
    try {
      RenderRepaintBoundary boundary =
          globalKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      Uint8List pngBytes = byteData!.buffer.asUint8List();

      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/QR_Code.png').create();
      await file.writeAsBytes(pngBytes);

      await Share.shareFiles(
        [file.path],
        text: 'Check out my QR code!',
      );
    } catch (e) {
      print('Error sharing image: $e');
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
          icon: const Icon(
            CupertinoIcons.arrow_left,
            color: Color(0xff3CB2E4),
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Done',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Color(0xff3CB2E4),
              ),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RepaintBoundary(
                    key: globalKey,
                    child: Container(
                      width: 264,
                      height: 264,
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFFFFF),
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: const EdgeInsets.all(30),
                      child: QrImageView(
                        data: widget.data,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    width: 398,
                    height: 68,
                    decoration: BoxDecoration(
                      color: const Color(0xFF3CB2E4),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          top: 22,
                          child: Row(
                            children: [
                              const SizedBox(width: 25),
                              SvgPicture.asset('assets/edit_style_icon.svg'),
                              const SizedBox(width: 15),
                              const Text(
                                'Change style',
                                style: TextStyle(
                                  color: Color(0xFFFFFFFF),
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              )
                            ],
                          ),
                        ),
                        Positioned(
                          top: 16,
                          left: 180,
                          child: Transform.rotate(
                            angle: 25 * 3.141592653589793 / 180,
                            child: Image.asset('assets/premium_icon.png'),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 25),
                  Container(
                    width: 398,
                    height: 162,
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: shareImage,
                          child: Row(
                            children: [
                              const SizedBox(width: 10),
                              SvgPicture.asset('assets/share_qr_icon.svg'),
                              const SizedBox(width: 15),
                              const Text(
                                'Share',
                                style: TextStyle(
                                  color: Color(0xff080808),
                                  fontWeight: FontWeight.w400,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: SizedBox(
                            width: 374,
                            child: Divider(
                              thickness: 1,
                              height: 1,
                              color: Color(0xffE4E4E7),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            const SizedBox(width: 10),
                            SvgPicture.asset('assets/delete_qr_icon.svg'),
                            const SizedBox(width: 15),
                            const Text(
                              'Delete',
                              style: TextStyle(
                                color: Color(0xffEF4444),
                                fontWeight: FontWeight.w400,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 15),
                        const Padding(
                          padding: EdgeInsets.only(left: 30),
                          child: SizedBox(
                            width: 374,
                            child: Divider(
                              thickness: 1,
                              height: 1,
                              color: Color(0xffE4E4E7),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
