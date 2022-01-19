import 'package:chat_bot/application/chat/chat_state.dart';
import 'package:chat_bot/application/notifications/notification_state.dart';
import 'package:chat_bot/presentation/chat/chat_screen.dart';
import 'package:chat_bot/presentation/home/home_screen.dart';
import 'package:chat_bot/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "/";

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final notitifer = context.read(notificationStateNotifier.notifier);
    if (state == AppLifecycleState.paused) {
      notitifer.canCreatenotifications(true);
      if (Navigator.canPop(context)) Navigator.pop(context);
    }
    if (state == AppLifecycleState.resumed) {
      notitifer.canCreatenotifications(false);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProviderListener<NotificationState>(
        provider: notificationStateNotifier,
        onChange: (context, state) {
          final notifier = context.read(notificationStateNotifier.notifier);
          if (!state.isNotificationAllowed && !state.permissionRequested) {
            notifier.requestPermission();
          }
          if (state.navigate) {
            notifier.clearNavigate();
            Navigator.pushNamedAndRemoveUntil(
                context, ChatScreen.routeName, (route) => route.isFirst);
          }
        },
        child: ProviderListener<ChatState>(
            provider: chatStateNotifier,
            onChange: (context, state) {
              final message = state.messageReceived;
              final user = context.read(currentUser);
              if (message != null && message.sender != user.uid) {
                context
                    .read(notificationStateNotifier.notifier)
                    .showNotification(
                        '${message.sender} has sent a new message.',
                        message.message);
                context.read(chatStateNotifier.notifier).clearNewMessage();
              }
            },
            child: HomeScreen()));
  }
}
