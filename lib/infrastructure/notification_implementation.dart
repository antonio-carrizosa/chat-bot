import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:chat_bot/core/repository/notification_repository.dart';
import 'package:flutter/material.dart';

class NotificationImplementation implements NotifycationRepository {
  static const String CHANNEL_KEY = "chat_channel";
  late AwesomeNotifications _awesomeNotifications;

  NotificationImplementation() {
    this._awesomeNotifications = AwesomeNotifications();
    _awesomeNotifications
        .initialize('resource://drawable/res_notification_app_icon', [
      NotificationChannel(
        channelKey: CHANNEL_KEY,
        channelName: 'Chat Notifications',
        defaultColor: Colors.blue,
        importance: NotificationImportance.High,
        channelShowBadge: true,
      ),
    ]);
  }

  @override
  Future<void> createNotification(String title, String body) async {
    await _awesomeNotifications.createNotification(
      content: NotificationContent(
          id: DateTime.now().millisecondsSinceEpoch.remainder(100000),
          channelKey: 'chat_channel',
          title: title,
          body: body,
          notificationLayout: NotificationLayout.Default),
    );
  }

  @override
  Future<bool> isNotificationAllowed() =>
      _awesomeNotifications.isNotificationAllowed();

  @override
  Future<void> requestPermission() =>
      _awesomeNotifications.requestPermissionToSendNotifications();

  @override
  Stream<ReceivedAction> get actionStream => _awesomeNotifications.actionStream;

  @override
  void decrementiOSBadge() {
    _awesomeNotifications.getGlobalBadgeCounter().then(
        (int value) => _awesomeNotifications.setGlobalBadgeCounter(value - 1));
  }

  @override
  void closeSink() {
    _awesomeNotifications.actionSink.close();
  }
}
