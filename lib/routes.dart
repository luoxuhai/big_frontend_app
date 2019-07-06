import 'dart:convert';
import 'package:fluro/fluro.dart';
import './pages/webview.dart';

class Routes {
  static Router router;
  static String root = "/";
  static String docDetilPage = '/docdetilpage';

  static void configureRoutes(Router router) {
    router.define(docDetilPage,
        handler: Handler(handlerFunc: (context, params) {
      String url = String.fromCharCodes(base64Decode(params['url']?.first));

      return DocDetilPage(url: url);
    }));
    Routes.router = router;
  }
}
