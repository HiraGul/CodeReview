import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/items.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/order_summary_pdf.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/pdf_api.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/pdf_controller.dart';

class GenerateVoucherPDF {
  static Future<Future<File?>> generateVoucherPdfFile(
      {required BuildContext buildContext}) async {
    var logo =
        (await rootBundle.load("assets/images/logo.png")).buffer.asUint8List();
    var bold = await PdfGoogleFonts.openSansBold();
    var normal = await PdfGoogleFonts.openSansMedium();
    var arabicFont = Font.ttf(await rootBundle.load("assets/fonts/arabic.ttf"));

    List<pw.Widget> items = [];
    items.add(pdfItemsBuilder(bold, normal, arabicFont));
    items.add(summaryPdf(bold, normal, arabicFont));

    PdfVoucherController.pdf = pw.Document();

    ///pdf generation
    PdfVoucherController.pdf.addPage(pw.MultiPage(
      maxPages: 1,
      margin: pw.EdgeInsets.zero,
      pageFormat: PdfPageFormat.a4,
      header: (context) => pw.Align(
          alignment: pw.Alignment.center,
          child: pw.Container(
              margin: pw.EdgeInsets.only(top: 10.sp),
              height: 150,
              width: 150,
              child: pw.Image(
                pw.MemoryImage(
                  logo,
                ),
              ))),
      build: (pw.Context context) => items,
      // footer: (context) =>
      //     ResultCardInvoiceMethods.invoiceFooter(tajawalBlack, poppins),
    ));

    return VoucherPDF.saveMyDocument(
      name: 'voucher.pdf',
      context: buildContext,
    );
  }
}
