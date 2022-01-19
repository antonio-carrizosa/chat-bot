import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ionicons/ionicons.dart';

class MessageBuilder extends HookWidget {
  final void Function(String msg) onMessage;

  const MessageBuilder({Key? key, required this.onMessage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = useTextEditingController();

    return SafeArea(
      top: false,
      bottom: true,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            _MessageInput(controller: controller),
            _SendButton(
              onPressed: () {
                final msg = controller.text.trim();
                if (msg.isNotEmpty) {
                  onMessage(msg);
                  controller.clear();
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  final void Function() onPressed;

  const _SendButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: 50,
        height: 50,
        decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(50)),
        child: Icon(
          Ionicons.send,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  final TextEditingController controller;

  const _MessageInput({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(25)),
      child: TextFormField(
        autofocus: true,
        controller: controller,
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        maxLines: null,
        decoration: InputDecoration(
          // hintText: "Say Hi",
          hintStyle: TextStyle(color: Colors.grey.shade300),
          border: InputBorder.none,
        ),
      ),
    ));
  }
}
