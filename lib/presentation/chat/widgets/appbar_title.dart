import 'package:chat_bot/core/models/user.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    Key? key,
    required this.bot,
  }) : super(key: key);

  final User bot;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(bot.name,
            style: TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold)),
        if (bot.isTyping)
          Text("Typing...",
              style: TextStyle(color: Colors.white60, fontSize: 12)),
      ],
    );
  }
}
