import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  handleDynamicLink() async {
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();
    _handleDeepLink(initialLink);

    FirebaseDynamicLinks.instance.onLink.listen(
      (pendingDynamicLinkData) {
        // Set up the `onLink` event listener next as it may be received here
        final Uri deepLink = pendingDynamicLinkData.link;
        // Example of using the dynamic link to push the user to a different screen
        _handleDeepLink(pendingDynamicLinkData);
      },
    );
  }

  _handleDeepLink(PendingDynamicLinkData? link) async {
    if (link != null) {
      print(link.link.path);
    }
  }
}
