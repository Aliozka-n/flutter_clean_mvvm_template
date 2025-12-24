import 'package:flutter/material.dart';

/// Navigation utility class
class NavigationUtil {
  NavigationUtil._();

  // Route names
  static const String splashScreen = '/splash';
  static const String homeScreen = '/home';
  static const String productListScreen = '/product-list';
  static const String productDetailScreen = '/product-detail';

  /// Navigate to a named route
  static Future<T?> navigateToNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and replace current route
  static Future<T?> navigateAndReplace<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, T>(
      routeName,
      arguments: arguments,
    );
  }

  /// Navigate and remove all previous routes
  static Future<T?> navigateAndRemoveUntil<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return Navigator.of(context).pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  /// Pop current route
  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  /// Pop until route
  static void popUntil(BuildContext context, String routeName) {
    Navigator.of(context).popUntil((route) => route.settings.name == routeName);
  }
}

