import 'package:chat_bot/application/chat/chat_provider.dart';
import 'package:chat_bot/infrastructure/chat_implementation.dart';
import 'package:chat_bot/presentation/home_screen.dart';
import 'package:chat_bot/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'core/models/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => ChatProvider(ChatImplementation())),
        Provider<User>(create: (_) => User(uid: '007', name: 'John'))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ChatBot',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: HomeScreen.routeName,
        onGenerateRoute: onGenerateRoute,
      ),
    );
  }
}
