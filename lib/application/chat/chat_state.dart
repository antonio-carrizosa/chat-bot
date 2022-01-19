import 'package:chat_bot/core/models/message.dart';

class ChatState {
  final List<Message> messages;
  final Message? messageReceived;
  final Message? selected;
  final String? reply;

  ChatState(
      {required this.messages,
      this.messageReceived,
      this.selected,
      this.reply});

  ChatState copyWith(
          {List<Message>? messages,
          Message? newMesage,
          Message? selected,
          String? reply}) =>
      ChatState(
          messages: messages ?? this.messages,
          messageReceived: newMesage,
          selected: selected,
          reply: reply);
}
