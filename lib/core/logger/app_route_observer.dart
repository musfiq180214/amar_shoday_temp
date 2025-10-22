import 'package:flutter/material.dart';
import 'package:amar_shoday/core/logger/app_logger.dart';

/// Logs only when the *visible route actually changes*.
class AppRouteObserver extends RouteObserver<PageRoute<dynamic>> {
  final _logger = AppLogger.getLogger('Amar Shoday');
  String? _lastRouteName;

  void _handleRouteChange(Route<dynamic>? route) {
    if (route == null) return;
    final name = route.settings.name;
    final currentRoute =
        (name != null && name.isNotEmpty) ? name : route.runtimeType.toString();

    if (currentRoute != _lastRouteName) {
      _lastRouteName = currentRoute;
      _logger.i('🧭 Current route: $currentRoute');
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    _handleRouteChange(route);
  }

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    _handleRouteChange(previousRoute);
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    _handleRouteChange(newRoute);
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    _handleRouteChange(previousRoute);
  }
}
