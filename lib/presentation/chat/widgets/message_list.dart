import 'package:chat_bot/presentation/chat/widgets/message_item.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  const MessageList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: ListView(
        reverse: true,
        physics: BouncingScrollPhysics(),
        children: [
          MessageItem(),
          MessageItem(isMe: true),
          MessageItem(),
          MessageItem(isMe: true),
          MessageItem(),
          MessageItem(isMe: true),
          MessageItem(),
        ],
      ),
    ));
  }
}
