import 'package:flutter/widgets.dart';

void handleNavigationTap(BuildContext context, int index) {
  switch (index) {
    case 0:
      Navigator.pushReplacementNamed(
        context,
        '/',
        arguments: {'wantedRoute': '/home'},
      );
      break;
    case 1:
      Navigator.pushReplacementNamed(
        context,
        '/',
        arguments: {'wantedRoute': '/cars'},
      );
      break;
    case 2:
      Navigator.pushReplacementNamed(
        context,
        '/',
        arguments: {'wantedRoute': '/profile'},
      );
      break;
    default:
      Navigator.pushReplacementNamed(
        context,
        '/',
        arguments: {'wantedRoute': '/home'},
      );
  }
}
