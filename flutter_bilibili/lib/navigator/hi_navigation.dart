import 'package:flutter/material.dart';
import 'package:flutter_bilibili/navigator/bottom_navigator.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';

///创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

enum RouterStatus { login, register, home, detail, unknown }

///获取routeStatus在页面堆栈中的位置
int getPageIndex(List<MaterialPage> pages, RouterStatus routerStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routerStatus) {
      return i;
    }

    return -1;
  }
}

///获取page 的状态
RouterStatus getStatus(MaterialPage page) {
  if (page.child is BottomNavigator) {
    return RouterStatus.home;
  } else if (page.child is Registration) {
    return RouterStatus.register;
  } else if (page.child is VideoDetailPage) {
    return RouterStatus.detail;
  } else if (page.child is LoginPage) {
    return RouterStatus.login;
  } else {
    return RouterStatus.unknown;
  }
}

typedef RouteChangeListener(RouterStatusInfo current, RouterStatusInfo pre);

class RouterStatusInfo {
  final RouterStatus routerStatus;
  final Widget page;

  RouterStatusInfo(this.routerStatus, this.page);
}

///监听路由页面跳转
///感知当前页面是否压后台
class HiNavigator extends _RouteJumpListener {
  static HiNavigator _instance;

  HiNavigator._();

  RouteJumpListener _routeJump;

  List<RouteChangeListener> _listeners = [];

  RouterStatusInfo _current;

  //首页底部tab
  RouterStatusInfo _bottomTab;

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._();
    }
    return _instance;
  }

  ///首页底部tab切换监听
  void onBottomTabChanged(int index, Widget page) {
    _bottomTab = RouterStatusInfo(RouterStatus.home, page);
    _notify(_bottomTab);
  }

  /// 注册路由跳转逻辑
  void registerRouteJump(RouteJumpListener listener) {
    this._routeJump = listener;
  }

  ///监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  ///移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void jumpTo(RouterStatus routerStatus, {Map<dynamic, dynamic> args}) {
    _routeJump.onJumpTo(routerStatus, args: args);
  }

  ///通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var currentPage =
        RouterStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    print('currentPages:${currentPage.page}');

    _notify(currentPage);
  }

  void _notify(RouterStatusInfo currentPage) {
    if (currentPage.page is BottomNavigator && _bottomTab != null) {
      //如果打开的是首页
      currentPage = _bottomTab;
    }
    print('hi_navigator:current:${currentPage.page}');
    print('hi_navigator:pre:${_current?.page}');
    _listeners.forEach((element) {
      element(currentPage, _current);
    });
    _current = currentPage;
  }
}

///抽象类供HiNavigator实现
abstract class _RouteJumpListener {
  void jumpTo(RouterStatus routerStatus, {Map args});
}

typedef OnJumpTo = void Function(RouterStatus routerStatus, {Map args});

///定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
