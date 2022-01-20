import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/models/reaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final bool isMe;
  final bool isSelected;
  const MessageItem(
      {Key? key,
      required this.message,
      this.isMe = false,
      this.isSelected = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          Stack(
            children: [
              GestureDetector(
                child: _MessageBubble(
                  isMe: isMe,
                  message: message,
                  isSelected: isSelected,
                ),
              ),
              if (message.reaction != null)
                Positioned(
                    right: 5,
                    top: 5,
                    child: Icon(
                      Reaction.getReactionIcon(message.reaction!),
                      color: Reaction.getReactionColor(message.reaction!),
                      size: 20,
                    ))
            ],
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble(
      {Key? key,
      required this.isMe,
      required this.message,
      required this.isSelected})
      : super(key: key);

  final bool isMe;
  final bool isSelected;
  final Message message;

  @override
  Widget build(BuildContext context) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(message.createdAt);
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: isSelected
              ? Colors.grey.shade600
              : isMe
                  ? Colors.green
                  : Theme.of(context).primaryColor,
          borderRadius: isMe
              ? const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                )),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message.reply != null)
                Text(
                  message.reply!,
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              Text(
                message.message,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ],
          ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${DateFormat.yMMMd().format(timestamp)} ${DateFormat.jm().format(timestamp)}',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
              if (isMe)
                Icon(
                    message.readed
                        ? Ionicons.checkmark_done
                        : Ionicons.checkmark,
                    color: Colors.white70,
                    size: 18),
            ],
          )
        ],
      ),
    );
  }
}
