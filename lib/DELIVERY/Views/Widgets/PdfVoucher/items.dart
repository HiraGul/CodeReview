import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:tojjar_delivery_app/DELIVERY/Data/DataController/order_detail_controller.dart';
import 'package:tojjar_delivery_app/DELIVERY/Utils/app_sharedPrefs.dart';

pdfItemsBuilder(boldText, mediumText, arabic) {
  return pw.ListView(children: [
    pw.Container(
      height: 100.sp,
      padding: pw.EdgeInsets.symmetric(horizontal: 20.sp),
      color: const PdfColor.fromInt(0xFFF6F6F6),
      child: pw.Align(
        alignment: MySharedPrefs.getLocale()!
            ? pw.Alignment.centerLeft
            : pw.Alignment.centerRight,
        child: pw.Text(
          'Items'.tr(),
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
    pw.Container(
      color: PdfColors.white,
      child: pw.ListView.separated(
        itemCount: OrderDetailsController.deliveredOrderList.length,

        itemBuilder: (context, index) {
          return pw.Padding(
            padding: pw.EdgeInsets.symmetric(vertical: 8.0, horizontal: 30.sp),
            child: MySharedPrefs.getLocale()!
                ? pw.Row(
                    children: [
                      /// Name of the quantity
                      pw.Expanded(
                        flex: 3,
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            OrderDetailsController
                                .deliveredOrderList[index].product!.name
                                .toString(),
                            style: pw.TextStyle(
                              fontSize: 20.0.sp,
                              color: const PdfColor.fromInt(0xFF111111),
                              font: mediumText,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '(${OrderDetailsController.deliveredOrderList[index].quantity}x)',
                            style: pw.TextStyle(
                              fontSize: 20.0.sp,
                              color: const PdfColor.fromInt(0xFF111111),
                              font: mediumText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                : pw.Row(
                    children: [
                      /// Name of the quantity
                      pw.SizedBox(width: 20.sp),

                      pw.Expanded(
                        child: pw.Align(
                          alignment: pw.Alignment.centerLeft,
                          child: pw.Text(
                            '(${OrderDetailsController.deliveredOrderList[index].quantity}x)',
                            style: pw.TextStyle(
                              fontSize: 20.0.sp,
                              color: const PdfColor.fromInt(0xFF111111),
                              font: mediumText,
                            ),
                          ),
                        ),
                      ),
                      pw.Expanded(
                        flex: 3,
                        child: pw.Align(
                          alignment: pw.Alignment.centerRight,
                          child: pw.Text(
                            OrderDetailsController
                                .deliveredOrderList[index].product!.name
                                .toString(),
                            style: pw.TextStyle(
                              fontSize: 20.0.sp,
                              color: const PdfColor.fromInt(0xFF111111),
                              font: mediumText,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
          );
        },

        /// this separatorBuilder is the line between the
        /// items
        separatorBuilder: (context, index) {
          return pw.Divider(
            thickness: 1,
          );
        },
      ),
    ),
  ]);
}
