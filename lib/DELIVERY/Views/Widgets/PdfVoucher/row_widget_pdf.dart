import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';

rowWidgetPdf(
    {required String title,
    required pw.Widget widget2,
    required dynamic font}) {
  return pw.Container(
    padding: pw.EdgeInsets.symmetric(horizontal: 20.sp),
    child: MySharedPrefs.getLocale()!
        ? pw.Row(
            children: [
              pw.Expanded(
                child: pw.Align(
                  alignment: MySharedPrefs.getLocale()!
                      ? pw.Alignment.centerLeft
                      : pw.Alignment.centerLeft,
                  child: pw.Text(
                    title,
                    style: pw.TextStyle(
                        fontSize: 20.0.sp,
                        color: PdfColor.fromInt(0xFF111111),
                        font: font),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ),
              ),
              pw.Expanded(
                child: pw.Align(child: widget2),
              ),
            ],
          )
        : pw.Row(
            children: [
              pw.Expanded(
                child: pw.Align(child: widget2),
              ),
              pw.Spacer(flex: 2),
              pw.Expanded(
                child: pw.Align(
                  alignment: MySharedPrefs.getLocale()!
                      ? pw.Alignment.centerRight
                      : pw.Alignment.centerRight,
                  child: pw.Text(
                    title,
                    style: pw.TextStyle(
                        fontSize: 20.0.sp,
                        color: PdfColor.fromInt(0xFF111111),
                        font: font),
                    textDirection: pw.TextDirection.rtl,
                  ),
                ),
              ),
            ],
          ),
  );
}
