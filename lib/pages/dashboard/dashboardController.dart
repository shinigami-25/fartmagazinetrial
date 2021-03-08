import 'package:fartmagazinetrial1/pages/home/home.dart';
import 'package:fartmagazinetrial1/pages/search/search.dart';
import 'package:fartmagazinetrial1/pages/showNoteLinks/showNoteLinks.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var tab = 0.obs;
  var allTabs = [Home(), Search()];
  var allTabsTitle = ['Home', 'Search'];

  @override
  void onInit() {
    super.onInit();
    initDynamicLinks();
  }

  initDynamicLinks() async {
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData dynamicLink) async {
      final Uri deepLink = dynamicLink?.link;
      if (deepLink != null) {
        String title = deepLink.queryParameters['title'].toString();
        String content = deepLink.queryParameters['content'].toString();
        String path = deepLink.queryParameters['path'].toString();
        Get.to(() => ShowNoteLinks(title, content, path));
      }
    }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      String title = deepLink.queryParameters['title'].toString();
      String content = deepLink.queryParameters['content'].toString();
      String path = deepLink.queryParameters['path'].toString();
      Get.to(() => ShowNoteLinks(title, content, path));
    }
  }
}
