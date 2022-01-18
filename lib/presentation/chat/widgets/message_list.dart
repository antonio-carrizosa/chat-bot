import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/presentation/chat/widgets/message_item.dart';
import 'package:flutter/material.dart';

class MessageList extends StatelessWidget {
  final User currentUser;
  final List<Message> messages;

  const MessageList(
      {Key? key, required this.messages, required this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        flex: 1,
        child: Container(
          color: Colors.white,
          padding: const EdgeInsets.all(8),
          child: ListView(
            physics: BouncingScrollPhysics(),
            reverse: true,
            children: messages.reversed
                .map((m) => MessageItem(
                      message: m,
                      isMe: currentUser.uid == m.sender,
                    ))
                .toList(),
          ),
        ));
  }
}
