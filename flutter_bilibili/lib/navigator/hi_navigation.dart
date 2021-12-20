import 'package:flutter/material.dart';
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
  if (page.child is HomePage) {
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

class RouterStatusInfo {
  final RouterStatus routerStatus;
  final Widget page;

  RouterStatusInfo(this.routerStatus, this.page);
}
