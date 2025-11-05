import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget implements PreferredSizeWidget {
  const MyAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0xFF101828),
      foregroundColor: Colors.white,
      title: Text(
        'Car Renting',
        style: TextStyle(
          fontSize: 25,
          fontFamily: 'Tajawal',
          fontWeight: FontWeight.bold,
        ),
      ),
      // title: Row(
      //   mainAxisAlignment: MainAxisAlignment.center,
      //   crossAxisAlignment: CrossAxisAlignment.center,
      //   children: [
      //     Image.asset(
      //       'assets/images/logo.png',
      //       fit: BoxFit.contain,
      //       height: 45,
      //     ),
      //     SizedBox(width: 20),
      //     Text(
      //       'Car Renting',
      //       style: TextStyle(
      //         fontSize: 25,
      //         fontFamily: 'Tajawal',
      //         fontWeight: FontWeight.bold,
      //       ),
      //     ),
      //   ],
      // ),
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
