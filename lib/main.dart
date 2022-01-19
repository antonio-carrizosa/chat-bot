import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:chat_bot/presentation/main_screen.dart';
import 'package:chat_bot/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ChatBot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MainScreen.routeName,
      onGenerateRoute: onGenerateRoute,
    );
  }
}
