import 'package:chat_bot/application/chat/chat_state.dart';
import 'package:chat_bot/application/chat/chat_state_notifier.dart';
import 'package:chat_bot/core/models/reaction.dart';
import 'package:chat_bot/presentation/chat/widgets/appbar_title.dart';
import 'package:chat_bot/providers.dart';
import 'package:flutter/material.dart';

import 'package:chat_bot/presentation/chat/widgets/message_builder.dart';
import 'package:chat_bot/presentation/chat/widgets/message_list.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ionicons/ionicons.dart';

class ChatScreen extends ConsumerWidget {
  static const String routeName = "/chat";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    return Consumer(
      builder: (context, watch, child) {
        final user = context.read(currentUser);
        final chatState = watch(chatStateNotifier);
        final chatNotifier = context.read(chatStateNotifier.notifier);
        final bot = watch(botUser);

        return Scaffold(
          backgroundColor: Colors.grey.shade300,
          appBar: AppBar(
            centerTitle: false,
            brightness: Brightness.dark,
            elevation: 0,
            title: AppBarTitle(bot: bot),
            actions:
                (chatState.selected != null) ? getActions(chatNotifier) : [],
          ),
          body: Column(
            children: [
              // AppBarContent(isTyping: chatProvider.isBotTyping),
              MessageList(
                messages: chatState.messages,
                currentUser: user,
                selectedMessage: chatState.selected,
                onSelected: (message) =>
                    chatNotifier.onMessageSelected(message),
              ),
              Column(
                children: [
                  if (chatState.reply != null)
                    ReplyBubble(
                      text: chatState.reply!,
                      cancel: () => chatNotifier.cancelReply(),
                    ),
                  MessageBuilder(
                    onMessage: (String msg) =>
                        chatNotifier.sendMessage(msg, user.uid),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  List<Widget> getActions(ChatStateNotifier chatNotifier) {
    return [
      ...Reaction.reactions.map((reaction) => IconButton(
            onPressed: () => chatNotifier.reactToMessage(reaction),
            icon: Icon(Reaction.getReactionIcon(reaction)),
          )),
      IconButton(
        onPressed: () => chatNotifier.reply(),
        icon: Icon(Ionicons.arrow_undo),
      ),
      IconButton(
        onPressed: () => chatNotifier.clearSelected(),
        icon: Icon(Ionicons.close),
      ),
    ];
  }
}

class ReplyBubble extends StatelessWidget {
  const ReplyBubble({
    Key? key,
    required this.text,
    required this.cancel,
  }) : super(key: key);

  final String text;
  final void Function() cancel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25)),
      width: MediaQuery.of(context).size.width,
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: Colors.white, fontSize: 16),
            ),
          ),
          IconButton(
            onPressed: cancel,
            icon: Icon(
              Ionicons.close,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
