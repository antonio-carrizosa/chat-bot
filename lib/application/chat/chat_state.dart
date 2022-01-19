import 'package:chat_bot/core/models/message.dart';

class ChatState {
  final List<Message> messages;
  final Message? messageReceived;

  ChatState({required this.messages, this.messageReceived});

  ChatState coptyWith({
    List<Message>? messages,
    Message? newMesage,
  }) =>
      ChatState(
        messages: messages ?? this.messages,
        messageReceived: newMesage,
      );
}
