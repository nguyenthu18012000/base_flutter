import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:swipeable_page_route/swipeable_page_route.dart';

class RouteConfig {
  RouteConfig._();

  static RouteConfig get instance => RouteConfig._();

  SwipeablePageRoute routes(RouteSettings settings) {
    return routeWithName(settings: settings);
  }

  SwipeablePageRoute routeWithName(
      {String? routeName, RouteSettings? settings}) {
    Widget widget;
    try {
      widget =
          GetIt.instance.get<Widget>(instanceName: routeName ?? settings?.name);
    } catch (e) {
      widget = Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(''),
        ),
        body: const Center(child: Text('Không tìm thấy trang')),
      );
    }
    return SwipeablePageRoute(
      builder: (BuildContext context) => widget,
      settings: settings,
    );
  }
}
