import 'package:flutter/material.dart';
import 'package:fluro/fluro.dart';
import 'package:order_device/pages/detail/index.dart';
import 'package:order_device/pages/detail/detailT.dart';
import 'package:order_device/pages/index_page/index.dart';
import 'package:order_device/pages/normal_page/normal_page.dart';
import 'package:order_device/pages/normal_page/left_list_view_page.dart';
import 'package:order_device/pages/routing_reference/routing_reference.dart';
import 'package:order_device/pages/login/login.dart';
import 'package:order_device/pages/login/user_agreement.dart';

/* *
 * handler就是每个路由的规则，编写handler就是配置路由规则，
 * 比如我们要传递参数，参数的值是什么，这些都需要在Handler中完成。
 */

// 首页
Handler indexPageHanderl = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return IndexPage();
  },
);

Handler detailPageHanderl = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return DetailPage();
  },
);

Handler normalPageHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return NormalPage();
});

// 测试列表
Handler listTestViewPage = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return LeftListViewPage();
});

// 路由传参
Handler routingReferenceHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  String id = params['id'].first;
  return RoutingReference(id: id);
});

// 登陆页面
Handler loginHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return Login();
});

Handler detailT = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return DetailPageT();
});

Handler userAgreementHanderl = Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
  return UserAgreement();
});
