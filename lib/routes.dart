import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import './pages/webview.dart';

class Routes {
  static Router router;
  static String root = "/";
  static String docDetilPage = '/docdetilpage';

  static void configureRoutes(Router router) {
    router.define(docDetilPage,
        handler: Handler(handlerFunc: (context, params) => DocDetilPage()));
    Routes.router = router;
  }
}
