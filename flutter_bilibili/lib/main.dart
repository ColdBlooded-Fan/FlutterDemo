import 'package:flutter/material.dart';
import 'package:flutter_bilibili/db/hi_cache.dart';
import 'package:flutter_bilibili/http/core/hi_error.dart';
import 'package:flutter_bilibili/http/core/hi_net.dart';
import 'package:flutter_bilibili/http/dao/login_dao.dart';
import 'package:flutter_bilibili/http/request/TestRequest.dart';
import 'package:flutter_bilibili/model/video_model.dart';
import 'package:flutter_bilibili/navigator/hi_navigation.dart';
import 'package:flutter_bilibili/page/home_page.dart';
import 'package:flutter_bilibili/page/login_page.dart';
import 'package:flutter_bilibili/page/registration_page.dart';
import 'package:flutter_bilibili/page/video_detail_page.dart';
import 'package:flutter_bilibili/util/color.dart';

void main() {
  runApp(BiliApp());
}

class BiliApp extends StatefulWidget {
  @override
  _BiliAppState createState() => _BiliAppState();
}

class _BiliAppState extends State<BiliApp> {
  BiliRouterDelegate _routerDelegate = BiliRouterDelegate();

  @override
  Widget build(BuildContext context) {
    //定义Router

    return FutureBuilder<HiCache>(
        //进行初始化
        future: HiCache.preInit(),
        builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
          var widget = snapshot.connectionState == ConnectionState.done
              ? Router(routerDelegate: _routerDelegate)
              : Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
          return MaterialApp(
            home: widget,
          );
        });
  }
}

class BiliRouterDelegate extends RouterDelegate<BiliRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<BiliRouterPath> {
  final GlobalKey<NavigatorState> navigatorKey;

  //为navigation设置一个key,必要的时候可以通过navigatorKey.currentState来获取到NavigatorState对象
  BiliRouterDelegate() : navigatorKey = GlobalKey<NavigatorState>();

  List<MaterialPage> pages = [];

  VideoModel videoModel;

  RouterStatus _routerStatus = RouterStatus.home;

  @override
  Widget build(BuildContext context) {
    //管理路由堆栈

    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    //构建路由堆栈
    if (index != -1) {
      //要打开的页面已经在堆栈中
      tempPages = tempPages.sublist(0, index);
    }
    var page;

    if (routeStatus == RouterStatus.home) {
      pages.clear();
      page = pageWrap(HomePage(onJumpDetail: (data) {
        this.videoModel = data;
        _routerStatus = RouterStatus.detail;
        notifyListeners();
      }));
    } else if (routeStatus == RouterStatus.detail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel));
    } else if (routeStatus == RouterStatus.register) {
      page = pageWrap(Registration(onJumpToLogin: () {
        _routerStatus = RouterStatus.login;
        notifyListeners();
      }));
    } else if (routeStatus == RouterStatus.home) {
      page = pageWrap(LoginPage());
    }
    //重新创建一个数组,否则pages因为引用没有改变路由不会变化
    tempPages = [...tempPages, page];

    pages = tempPages;

    return Navigator(
      key: navigatorKey,
      pages: pages,
      onPopPage: (route, result) {
        //这里处理是否可以返回上个页面
        if (!route.didPop(result)) {
          return false;
        }
        return true;
      },
    );
  }

  RouterStatus get routeStatus {
    if (_routerStatus != RouterStatus.register && !hasLogin) {
      return _routerStatus = RouterStatus.login;
    }

    return _routerStatus;
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(BiliRouterPath configuration) {}
}

class BiliRouterPath {
  final String location;

  BiliRouterPath.home() : location = "/";

  BiliRouterPath.detail() : location = "/";
}

// ///创建页面
// pageWrap(Widget child) {
//   return MaterialPage(key: ValueKey(child.hashCode), child: child);
// }
