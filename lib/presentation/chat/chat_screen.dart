import 'package:chat_bot/presentation/chat/widgets/appbar_title.dart';
import 'package:chat_bot/providers.dart';
import 'package:flutter/material.dart';

import 'package:chat_bot/presentation/chat/widgets/message_builder.dart';
import 'package:chat_bot/presentation/chat/widgets/message_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = "/chat";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Consumer(
      builder: (context, watch, child) {
        final user = context.read(currentUser);
        final chatNotifier = watch(chatStateNotifier);
        final bot = watch(botUser);
        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            centerTitle: false,
            brightness: Brightness.dark,
            elevation: 0,
            title: AppBarTitle(bot: bot),
          ),
          body: Column(
            children: [
              // AppBarContent(isTyping: chatProvider.isBotTyping),
              MessageList(
                messages: chatNotifier.messages,
                currentUser: user,
              ),
              MessageBuilder(
                onMessage: (String msg) => context
                    .read(chatStateNotifier.notifier)
                    .sendMessage(msg, user.uid),
              ),
            ],
          ),
        );
      },
    );
  }
}
