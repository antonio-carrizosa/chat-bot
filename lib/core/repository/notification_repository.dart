abstract class NotificationRepository {
  Future<void> createNotification(String title, String body);
  Future<bool> isNotificationAllowed();
  Future<void> requestPermission();
  Stream<String> get actionChannelKeyStream;
  void closeSink();
  void decrementiOSBadge();
}
