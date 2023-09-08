import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';

class DynamicLink {
  static Future<String> createLink(user) async {
    // String url = 'https://tujjar.com/api/user?ref_id=$refId';
    // String url = "https://play.google.com/store/apps/";
    // String url = "https://tojjar.jmmtest.com/";
    // String url = "https://shazam.com/";
    // String url = "https://jmm.tujjar.tujjar_woocommerce.com/";
    // String url = 'https://tojjar-backend.jmmtest.com/api/v2/auth/login';

    String url = "https://tojjar.com/api/v2?user=$user";
    final dynamicLinkParams = DynamicLinkParameters(
      link: Uri.parse(url),
      uriPrefix: "https://tujjar.page.link",
      iosParameters: const IOSParameters(
        bundleId: "com.jmm.tojjarEcommerce",
        minimumVersion: '0',
      ),
      androidParameters: const AndroidParameters(
        packageName: "com.jmm.tujjar.tujjar_woocommerce",
        // packageName: "com.shazam.android",
        // packageName: 'com.example.tojjar_delivery_app',
        minimumVersion: 0,
      ),
    );
    // final link = dynamicLinkParams.link.replace(queryParameters: {
    //   'username': username,
    //   'password': password,
    // });
    // dynamicLinkParams.link = link;
    final dynamicLink = await FirebaseDynamicLinks.instance.buildShortLink(
      dynamicLinkParams,
      // shortLinkType: ShortDynamicLinkType.unguessable
    );
    debugPrint("The short dynamic link is ==== ${dynamicLink.shortUrl}");
    return dynamicLink.shortUrl.toString();
  }

  static Future<String?> initDynamicLinks() async {
    // Get any initial links
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      final Uri deepLink = initialLink.link;
      return deepLink.queryParameters['ref_id'].toString();
      // Example of using the dynamic link to push the user to a different screen
    }
    return null;
  }
}
