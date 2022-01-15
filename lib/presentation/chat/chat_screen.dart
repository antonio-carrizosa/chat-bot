import 'package:chat_bot/presentation/chat/widgets/message_builder.dart';
import 'package:chat_bot/presentation/chat/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = "/chat";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            _AppBarContent(),
            MessageList(),
            MessageBuilder(),
          ],
        ),
      ),
    );
  }
}

class _AppBarContent extends StatelessWidget {
  const _AppBarContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Row(
          children: [
            InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Ionicons.arrow_back, color: Colors.white)),
            const SizedBox(width: 8),
            Icon(Ionicons.logo_octocat, color: Colors.white, size: 30),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Chatbot",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                Text("Typing...",
                    style: TextStyle(color: Colors.white60, fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
