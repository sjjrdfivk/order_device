import 'package:color_dart/color_dart.dart';
import 'package:flutter/material.dart';
import 'package:order_device/utils/loading.dart';

/// 这个类是用来处理全局的Global的tools类
class G {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

  /// 初始化loading
  static final Loading loading = Loading();

  /// 手动延时
  static sleep({int milliseconds = 1000}) async =>
      await Future.delayed(Duration(milliseconds: milliseconds));

  /// 下拉刷新样式
  // static final PullToRefreshStyle pullToRefreshStyle = PullToRefreshStyle();

  /// 获取当前的state
  static NavigatorState getCurrentState() => navigatorKey.currentState;

  /// 获取当前的context
  static BuildContext getCurrentContext() => navigatorKey.currentContext;

  /// 获取屏幕上下边距
  /// 用于兼容全面屏，刘海屏
  static EdgeInsets screenPadding() =>
      MediaQuery.of(getCurrentContext()).padding;

  /// 获取屏幕宽度
  static double screenWidth() => MediaQuery.of(getCurrentContext()).size.width;

  /// 获取屏幕高度
  static double screenHeight() =>
      MediaQuery.of(getCurrentContext()).size.height;

  /// 底部border
  /// ```
  /// @param {Color} color
  /// @param {bool} show  是否显示底部border
  /// ```
  static Border borderBottom({Color color, bool show = true}) {
    return Border(
        bottom: BorderSide(
            color: (color == null || !show)
                ? (show ? rgba(242, 242, 242, 1) : Colors.transparent)
                : color,
            width: 1));
  }

  /// 获取时间戳
  /// 不传值 代表获取当前时间戳
  static int getTime([DateTime time]) {
    if (time == null) {
      return (DateTime.now().millisecondsSinceEpoch / 1000).round();
    } else {
      return (time.millisecondsSinceEpoch / 1000).round();
    }
  }
}
