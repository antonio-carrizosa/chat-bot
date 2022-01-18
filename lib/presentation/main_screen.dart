import 'dart:io';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_bot/presentation/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:chat_bot/application/chat/chat_provider.dart';
import 'package:chat_bot/core/repository/notification_repository.dart';
import 'package:chat_bot/infrastructure/notification_implementation.dart';
import 'package:chat_bot/presentation/chat/chat_screen.dart';
import 'package:chat_bot/presentation/common/alert_dialog.dart';

class MainScreen extends StatefulWidget {
  static const String routeName = "/";

  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  late ChatProvider chatProvider;
  late NotifycationRepository notificationRepository;

  @override
  void initState() {
    chatProvider = Provider.of<ChatProvider>(context, listen: false);
    notificationRepository =
        Provider.of<NotifycationRepository>(context, listen: false);
    notificationRepository
      ..isNotificationAllowed().then((isAllowed) {
        if (!isAllowed) {
          _requestPermision();
        }
      })
      ..actionStream.listen(_handleAction);
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      chatProvider.createNotification = true;
    }
    if (state == AppLifecycleState.resumed) {
      chatProvider.createNotification = false;
    }
  }

  Future<void> _requestPermision() {
    return showDialog(
      context: context,
      builder: (context) => showAllowNotificationsDialog(
        allow: () async {
          notificationRepository
              .requestPermission()
              .then((_) => Navigator.pop(context));
        },
        denie: () => Navigator.pop(context),
      ),
    );
  }

  void _handleAction(ReceivedAction action) async {
    if (action.channelKey == NotificationImplementation.CHANNEL_KEY &&
        Platform.isIOS) {
      notificationRepository.decrementiOSBadge();
    }
    if (action.channelKey == NotificationImplementation.CHANNEL_KEY) {
      if (Navigator.of(context).isCurrent(ChatScreen.routeName)) {
        await Navigator.pushNamedAndRemoveUntil(
            context, ChatScreen.routeName, (route) => route.isFirst);
        chatProvider.createNotification = true;
      }
    }
  }

  @override
  void dispose() {
    notificationRepository.closeSink();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return HomeScreen();
  }
}
