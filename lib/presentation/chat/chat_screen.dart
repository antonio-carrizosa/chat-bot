import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';
import 'package:chat_bot/application/chat/chat_state_notifier.dart';
import 'package:chat_bot/core/models/reaction.dart';
import 'package:chat_bot/presentation/chat/widgets/appbar_title.dart';
import 'package:chat_bot/presentation/chat/widgets/reply_bubble.dart';
import 'package:chat_bot/providers.dart';
import 'package:chat_bot/presentation/chat/widgets/message_builder.dart';
import 'package:chat_bot/presentation/chat/widgets/message_list.dart';

class ChatScreen extends HookWidget {
  static const String routeName = "/chat";
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final scrollController = useScrollController();

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
                scrollController: scrollController,
              ),
              Column(
                children: [
                  if (chatState.reply != null)
                    ReplyBubble(
                      text: chatState.reply!,
                      cancel: () => chatNotifier.cancelReply(),
                    ),
                  MessageBuilder(
                    onMessage: (String msg) {
                      chatNotifier.sendMessage(msg, user.uid);
                      scrollController.jumpTo(0);
                    },
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
      ...Reaction.reactions.map((reaction) => SlideInUp(
            duration: const Duration(milliseconds: 250),
            from: 5,
            child: IconButton(
              onPressed: () => chatNotifier.reactToMessage(reaction),
              icon: Icon(Reaction.getReactionIcon(reaction)),
            ),
          )),
      SlideInUp(
        from: 5,
        duration: const Duration(milliseconds: 250),
        child: IconButton(
          onPressed: () => chatNotifier.reply(),
          icon: Icon(Ionicons.arrow_undo),
        ),
      ),
      SlideInUp(
        from: 5,
        duration: const Duration(milliseconds: 250),
        child: IconButton(
          onPressed: () => chatNotifier.clearSelected(),
          icon: Icon(Ionicons.close),
        ),
      ),
    ];
  }
}
