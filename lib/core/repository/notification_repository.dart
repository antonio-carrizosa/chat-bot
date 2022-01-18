import 'package:awesome_notifications/awesome_notifications.dart';

abstract class NotifycationRepository {
  Future<void> createNotification(String title, String body);
  Future<bool> isNotificationAllowed();
  Future<void> requestPermission();
  Stream<ReceivedAction> get actionStream;
  void closeSink();
  void decrementiOSBadge();
}
