import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:weather/resources/config/navigation_path.dart';
import 'package:weather/ui/about/about_page.dart';
import 'package:weather/ui/main/main_screen.dart';

///应用导航器:定义导航路由
class NavigationProvider {
  final router = FluroRouter();

  ///主页
  final _mainScreenHandler = Handler(handlerFunc: (context, params) {
    return const MainScreen();
  });

  ///关于
  final _aboutPageHandler = Handler(handlerFunc: (context, params) {
    return AboutPage();
  });

  ///定义路由列表
  void defineRotes() {
    router.define(NavigationPath.mainPagePath, handler: _mainScreenHandler);
    router.define(NavigationPath.aboutPagePath, handler: _aboutPageHandler);
  }

  ///跳转
  void navigationToPath(String path, GlobalKey<NavigatorState> natigatorKey,
      {RouteSettings? routeSettings}) {
    router.navigateTo(
      natigatorKey.currentState!.context,
      path,
      routeSettings: routeSettings,
      transition: TransitionType.material,
      transitionDuration: const Duration(milliseconds: 300),
    );
  }
}
