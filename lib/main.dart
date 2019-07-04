import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'utils/class_builder.dart';
import 'package:big_frontend/pages/main/index.dart';
import './routes.dart';

void main() {
  /// 初始化并配置路由
  final router = Router();
  Routes.configureRoutes(router);
  ClassBuilder.registerClasses();
  runApp(MyApp(Routes.router.generator));
  /// 沉浸状态栏
  if (Platform.isAndroid) {
    SystemUiOverlayStyle systemUiOverlayStyle =
        SystemUiOverlayStyle(statusBarColor: Colors.transparent);
    SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  }
}

class MyApp extends StatelessWidget {
  final generator;
  MyApp(this.generator);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '大前端',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainWidget(),
      onGenerateRoute: Routes.router.generator,
    );
  }
}
