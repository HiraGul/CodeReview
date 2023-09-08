import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:printing/printing.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/pdf_controller.dart';
import 'package:tojjar_delivery_app/commonWidgets/snackbar.dart';

class VoucherPDF {
  static Future<File?> saveMyDocument({
    required String name,
    required BuildContext context,
  }) async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      await Permission.storage.request();
    }
    status = await Permission.storage.status;
    if (status.isGranted) {
      final bytes = await PdfVoucherController.pdf.save();
      Directory appDocDir = await getApplicationDocumentsDirectory();

      final file = File('${appDocDir.path}$name');
      await file.writeAsBytes(bytes);

      await Printing.layoutPdf(
          onLayout: (PdfPageFormat format) async =>
              PdfVoucherController.pdf.save());

      return file;
    } else {
      if (context.mounted) {
        showMessageSnackBar(context, "Sorry Permission is denied");
      }
    }
  }
}
