import 'package:flutter/material.dart';

class NavigationService {
  static final NavigationService instance = NavigationService._internal();

  NavigationService._internal();

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  Future<dynamic> navigateToRoute(MaterialPageRoute route) async {
    return navigatorKey.currentState?.push(route);
  }

  Future<dynamic> navigateTo(String routeName) async {
    return navigatorKey.currentState?.pushNamed(routeName);
  }

  void goBack() {
    navigatorKey.currentState?.pop();
  }
}
