import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final bool showBack;

  const MyAppBar({super.key, this.title, this.actions, this.showBack = false});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF101828),
      foregroundColor: Colors.white,
      centerTitle: true,
      automaticallyImplyLeading: showBack,
      title: Text(
        title ?? 'Car Renting',
        style: const TextStyle(
          fontSize: 25,
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
