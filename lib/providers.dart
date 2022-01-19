import 'package:chat_bot/application/chat/chat_state.dart';
import 'package:chat_bot/application/bot/bot_state_notifier.dart';
import 'package:chat_bot/application/chat/chat_state_notifier.dart';
import 'package:chat_bot/application/notifications/notification_notifier.dart';
import 'package:chat_bot/application/notifications/notification_state.dart';
import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/core/repository/chat_repository.dart';
import 'package:chat_bot/infrastructure/chat_implementation.dart';
import 'package:chat_bot/core/repository/notification_repository.dart';
import 'package:chat_bot/infrastructure/notification_implementation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final notificationRepository =
    Provider<NotificationRepository>((_) => NotificationImplementation());

final chatRepository = Provider<ChatRepository>((_) => ChatImplementation());

final notificationStateNotifier =
    StateNotifierProvider<NotificationStateNotifier, NotificationState>(
  (ref) => NotificationStateNotifier(ref.watch(notificationRepository)),
);

final chatStateNotifier = StateNotifierProvider<ChatStateNotifier, ChatState>(
    (ref) => ChatStateNotifier(ref.watch(chatRepository)));

final botUser = StateNotifierProvider<BotStateNotifier, User>(
    (ref) => BotStateNotifier(ref.watch(chatRepository)));

final currentUser = Provider<User>((_) => User.currentUser);
