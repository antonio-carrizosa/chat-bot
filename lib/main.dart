import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:chat_bot/application/chat/chat_provider.dart';
import 'package:chat_bot/core/repository/notification_repository.dart';
import 'package:chat_bot/infrastructure/chat_implementation.dart';
import 'package:chat_bot/infrastructure/notification_implementation.dart';
import 'package:chat_bot/presentation/main_screen.dart';
import 'package:chat_bot/router.dart';

import 'core/models/user.dart';

void main() {
  final _notifycationRepository = NotificationImplementation();
  runApp(MyApp(_notifycationRepository));
}

class MyApp extends StatelessWidget {
  final NotifycationRepository notifycationRepository;
  const MyApp(
    this.notifycationRepository, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    final currentUser = User(uid: '007', name: 'John');

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ChatProvider(
                ChatImplementation(), notifycationRepository, currentUser)),
        Provider<User>(create: (_) => currentUser),
        Provider<NotifycationRepository>(create: (_) => notifycationRepository),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatBot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: MainScreen.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
