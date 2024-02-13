import 'package:barcode_widget/barcode_widget.dart';


class QRCodeModel {
  QRCodeModel({
    required this.data,
    required this.category,
    required this.date,
    required this.type,
  });
  final String data;
  final String category;
  final DateTime date;
  final Barcode type;
}
