import 'package:animate_do/animate_do.dart';
import 'package:chat_bot/core/models/message.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';

class MessageItem extends StatelessWidget {
  final Message message;
  final bool isMe;
  const MessageItem({Key? key, required this.message, this.isMe = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final timestamp = DateTime.fromMillisecondsSinceEpoch(message.createdAt);

    return FadeInUp(
      from: 5,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Row(
            mainAxisAlignment:
                isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: isMe
                        ? Colors.grey.shade900
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
                    Row(
                      children: [
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
                          Icon(Ionicons.checkmark_done,
                              color:
                                  message.readed ? Colors.blue : Colors.white70,
                              size: 18),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
