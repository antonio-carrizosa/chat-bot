import 'package:chat_bot/presentation/chat/chat_screen.dart';
import 'package:chat_bot/presentation/common/error_page_screen.dart';
import 'package:flutter/material.dart';

import 'presentation/main_screen.dart';

Route<dynamic>? onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case MainScreen.routeName:
      return MaterialPageRoute(builder: (_) => MainScreen());
    case ChatScreen.routeName:
      return PageRouteBuilder(
        pageBuilder: (context, animation, _) {
          final curve =
              CurvedAnimation(parent: animation, curve: Curves.easeIn);

          return SlideTransition(
            position: Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0))
                .animate(curve),
            child: ChatScreen(),
          );
        },
      );
    default:
      return MaterialPageRoute(
        builder: (_) => ErrorPageScreen(route: settings.name ?? 'undefined'),
      );
  }
}
