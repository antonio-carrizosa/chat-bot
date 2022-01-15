import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MessageItem extends StatelessWidget {
  final bool isMe;
  const MessageItem({Key? key, this.isMe = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.start : MainAxisAlignment.end,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: isMe
                    ? const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20))
                    : const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20))),
            child: Column(
              children: [
                Text(
                  "If the [style] argument is null, the text will use the style from the closest enclosing [DefaultTextStyle].",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
                SizedBox(height: 6),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      "2 de Enero del 2020",
                      style: TextStyle(color: Colors.white70),
                    ),
                    SizedBox(width: 8),
                    Icon(Ionicons.checkmark_done,
                        color: Colors.white70, size: 20),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
