import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/pdf_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Views/Widgets/PdfVoucher/row_widget_pdf.dart';

summaryPdf(boldText, mediumText, arabic) {
  return pw.Container(
    child: pw.ListView(
      padding: pw.EdgeInsets.zero,
      children: [
        pw.SizedBox(height: 40.sp),
        pw.Container(
          width: 10.sw,
          height: 100.sp,
          padding: pw.EdgeInsets.symmetric(horizontal: 20.sp),
          color: const PdfColor.fromInt(0xFFF6F6F6),
          child: pw.Align(
            alignment: MySharedPrefs.getLocale()!
                ? pw.Alignment.centerLeft
                : pw.Alignment.centerRight,
            child: pw.Text(
              'Summary'.tr(),
              style: pw.TextStyle(
                fontSize: 30.0.sp,
                color: const PdfColor.fromInt(0xFF111111),
                font: MySharedPrefs.getLocale()! ? boldText : arabic,
              ),
              textDirection: pw.TextDirection.rtl,
            ),
          ),
        ),
        pw.SizedBox(height: 20.sp),
        pw.ListView(
          children: [
            rowWidgetPdf(
              title: 'Delivery Charges'.tr(),
              widget2: pw.Text(
                'FREE Delivery'.tr(),
                style: pw.TextStyle(
                  fontSize: 20.0.sp,
                  color: const PdfColor.fromInt(0xFF4F7491),
                  font: MySharedPrefs.getLocale()! ? mediumText : arabic,
                ),
                textDirection: pw.TextDirection.rtl,
              ),
              font: MySharedPrefs.getLocale()! ? mediumText : arabic,
            ),
            pw.Divider(color: PdfColors.grey.shade(0.2)),
            rowWidgetPdf(
              title: "VAT".tr(),
              widget2: pw.Text(
                '${PdfVoucherController.vat} SAR',
                style: pw.TextStyle(
                  fontSize: 20.0.sp,
                  color: const PdfColor.fromInt(0xFF111111),
                  font: MySharedPrefs.getLocale()! ? mediumText : arabic,
                ),
              ),
              font: MySharedPrefs.getLocale()! ? mediumText : arabic,
            ),
            pw.SizedBox(height: 10.sp),
            rowWidgetPdf(
              title: "Sub Total".tr(),
              widget2: pw.Text(
                '${PdfVoucherController.subTotal} SAR',
                style: pw.TextStyle(
                  fontSize: 20.0.sp,
                  color: const PdfColor.fromInt(0xFF111111),
                  font: MySharedPrefs.getLocale()! ? mediumText : arabic,
                ),
              ),
              font: MySharedPrefs.getLocale()! ? mediumText : arabic,
            ),
            pw.Divider(color: PdfColors.grey.shade(0.2)),
            rowWidgetPdf(
              title: "Total Price".tr(),
              widget2: pw.Text(
                '${PdfVoucherController.price} SAR',
                style: pw.TextStyle(
                  fontSize: 20.0.sp,
                  color: const PdfColor.fromInt(0xFFF89321),
                  font: MySharedPrefs.getLocale()! ? mediumText : arabic,
                ),
              ),
              font: MySharedPrefs.getLocale()! ? mediumText : arabic,
            ),
          ],
        ),
      ],
    ),
  );
}
