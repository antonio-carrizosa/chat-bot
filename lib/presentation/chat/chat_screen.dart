import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:chat_bot/application/chat/chat_provider.dart';
import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/presentation/chat/widgets/appbar.dart';
import 'package:chat_bot/presentation/chat/widgets/message_builder.dart';
import 'package:chat_bot/presentation/chat/widgets/message_list.dart';

class ChatScreen extends StatelessWidget {
  static const String routeName = "/chat";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<User>(context);
    final chatProvider = Provider.of<ChatProvider>(context);

    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        title: Column(
          children: [
            Text("Chatbot",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold)),
            if (chatProvider.isBotTyping)
              Text("Typing...",
                  style: TextStyle(color: Colors.white60, fontSize: 12)),
          ],
        ),
      ),
      body: Column(
        children: [
          // AppBarContent(isTyping: chatProvider.isBotTyping),
          MessageList(
            messages: chatProvider.messages,
            currentUser: currentUser,
          ),
          MessageBuilder(
            onMessage: (String msg) {
              final timestamp = DateTime.now().millisecondsSinceEpoch;
              final message = Message(
                  uid: Uuid().v4(),
                  sender: currentUser.uid,
                  message: msg,
                  createdAt: timestamp);
              Provider.of<ChatProvider>(context, listen: false)
                  .sendMessage(message);
            },
          ),
        ],
      ),
    );
  }
}
