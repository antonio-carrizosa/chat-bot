import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/models/user.dart';

abstract class ChatRepository {
  void sendMessage(Message message);
  Stream<Message> onMessageReceived();
  Stream<User> onBotStateChange();
  void dispose();
}
