import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'login_screen.dart';

typedef ScreenBuilder = Widget Function(
    BuildContext context, Object? arguments);

class ScreenRouteGenerator {
  final Map<String, ScreenBuilder> overrides;
  final Map<String, String> redirects;

  const ScreenRouteGenerator({
    this.overrides = const {},
    this.redirects = const {},
  });

  static final Map<String, ScreenBuilder> _routes = {
    Screens.home: (_, arguments) => const HomeScreen(),
    Screens.login: (_, arguments) => const LoginScreen(),
  };

  ScreenBuilder? _find(String? name) {
    final override = overrides[name];
    if (override != null) return override;
    final redirect = redirects[name];
    if (redirect != null) return _routes[redirect];
    return _routes[name];
  }

  MaterialPageRoute call(RouteSettings settings) {
    final builder = _find(settings.name);
    if (builder != null) {
      return MaterialPageRoute(
          builder: (context) => builder(context, settings.arguments));
    }
    throw Exception('${settings.name} route not found');
  }
}

class Screens {
  static const home = '/';
  static const login = '/login';
}
