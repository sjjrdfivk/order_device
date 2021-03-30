import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import './router_handler.dart';

class Routes {
  // 定义路由名称
  static String root = '/';
  static String indexPage = '/indexPage';
  static String normalPage = '/normalPage';
  static String detail = '/detail';
  static String routingReference = '/routingReference';
  static String login = '/login';
  static String detailP = '/detailT';
  static String userAgreement = '/user_agreement';
  static String listTestPage = '/list_test_page';
  // 定义路由处理函数
  static void configureRoutes(FluroRouter router) {
    router.notFoundHandler = new Handler(
      // ignore: missing_return
      handlerFunc: (BuildContext context, Map<String, List<String>> params) {
        print('ERROR====>ROUTE WAS NOT FONUND!!!');
        print('找不到路由，404');
      },
    );

    // 路由页面配置
    router.define(detail, handler: detailPageHanderl);
    router.define(detailP, handler: detailT);
    router.define(normalPage, handler: normalPageHanderl);
    router.define(routingReference, handler: routingReferenceHanderl);
    router.define(login, handler: loginHanderl);
    router.define(userAgreement, handler: userAgreementHanderl);
    router.define(listTestPage, handler: listTestViewPage);
  }
}
