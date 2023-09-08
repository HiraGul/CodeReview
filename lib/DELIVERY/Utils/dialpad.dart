import 'package:flutter/cupertino.dart';
import 'package:tojjar_delivery_app/commonWidgets/snackbar.dart';
import 'package:url_launcher/url_launcher.dart';

class DialPadLauncher {
  static launch(
    String phoneNumber,
    BuildContext context,
  ) async {
    try {
      if (phoneNumber == 'null' || phoneNumber == null || phoneNumber == '') {
        showMessageSnackBar(context, 'Phone Number is Empty');
      } else {
        final Uri uri = Uri(scheme: 'tel', path: phoneNumber);
        if (await canLaunchUrl(uri)) {
          await launchUrl(
            uri,
          );
        } else {
          if (context.mounted) {
            showMessageSnackBar(context, 'Could not Launch Url');
          }
        }
      }
    } catch (e) {
      if (context.mounted) {
        showMessageSnackBar(context, 'Could not Launch Url');
      }
    }
  }
}
