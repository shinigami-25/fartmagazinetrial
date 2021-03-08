import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

class DynamicLinkService {
  Future<Uri> createDynamicLinks(String title, String content, String path) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://fartmagazinetrial1.page.link',
      link: Uri.parse('https://$title.com/?title=$title&content=$content&path=$path'),
      androidParameters: AndroidParameters(
        packageName: 'com.example.fartmagazinetrial1',
        minimumVersion: 1,
      ),
      googleAnalyticsParameters: GoogleAnalyticsParameters(
        campaign: 'example-promo',
        medium: 'social',
        source: 'orkut',
      ),
    );

    ShortDynamicLink shortLink = await parameters.buildShortLink();
    
    return shortLink.shortUrl;
  }
}
