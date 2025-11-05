import 'package:flutter/widgets.dart';

void handleNavigationTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (Route<dynamic> route) => false,
        arguments: {'wantedRoute': '/home'},
      );
      break;
    case 1:
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (Route<dynamic> route) => false,
        arguments: {'wantedRoute': '/cars'},
      );
      break;
    case 2:
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (Route<dynamic> route) => false,
        arguments: {'wantedRoute': '/profile'},
      );
      break;
    default:
      Navigator.pushNamedAndRemoveUntil(
        context,
        '/',
        (Route<dynamic> route) => false,
        arguments: {'wantedRoute': '/home'},
      );
  }
}
