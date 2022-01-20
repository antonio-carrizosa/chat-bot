import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/presentation/chat/widgets/message_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class MessageList extends HookWidget {
  final User currentUser;
  final List<Message> messages;
  final void Function(Message message) onSelected;
  final Message? selectedMessage;
  final ScrollController scrollController;

  const MessageList(
      {Key? key,
      required this.messages,
      required this.currentUser,
      required this.onSelected,
      required this.scrollController,
      this.selectedMessage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ListView(
        physics: BouncingScrollPhysics(),
        controller: scrollController,
        reverse: true,
        children: messages.reversed
            .map(
              (m) => GestureDetector(
                onLongPress: () => onSelected(m),
                child: MessageItem(
                  message: m,
                  isMe: currentUser.uid == m.sender,
                  isSelected: selectedMessage?.uid == m.uid,
                ),
              ),
            )
            .toList(),
      ),
    ));
  }
}
