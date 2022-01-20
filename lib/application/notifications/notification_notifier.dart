import 'dart:io';
import 'package:chat_bot/application/notifications/notification_state.dart';
import 'package:chat_bot/core/repository/notification_repository.dart';
import 'package:chat_bot/infrastructure/notification_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NotificationStateNotifier extends StateNotifier<NotificationState> {
  final NotificationRepository _repository;

  NotificationStateNotifier(this._repository) : super(NotificationState()) {
    init();
  }

  bool _canCreatenotifications = false;
  void canCreatenotifications(bool value) {
    _canCreatenotifications = value;
  }

  Future<void> init() async {
    final isNotificationAllowed = await _repository.isNotificationAllowed();
    state = state.copyWith(isNotificationAllowed: isNotificationAllowed);
    _repository.actionChannelKeyStream.listen(_handleAction);
  }

  Future<void> requestPermission() async {
    await _repository.requestPermission();
    final isNotificationAllowed = await _repository.isNotificationAllowed();
    state = state.copyWith(
        permissionRequested: true,
        isNotificationAllowed: isNotificationAllowed);
  }

  Future<void> showNotification(String title, String body) async {
    if (state.isNotificationAllowed && _canCreatenotifications) {
      await _repository.createNotification(title, body);
    }
  }

  @override
  void dispose() {
    _repository.closeSink();
    super.dispose();
  }

  void _handleAction(String channelKey) async {
    if (channelKey == NotificationImplementation.CHANNEL_KEY &&
        Platform.isIOS) {
      await _repository.decrementiOSBadge();
    }
    if (channelKey == NotificationImplementation.CHANNEL_KEY &&
        _canCreatenotifications) {
      state = state.copyWith(navigate: true);
    }
  }

  void clearNavigate() {
    state = state.copyWith(navigate: false);
  }
}
