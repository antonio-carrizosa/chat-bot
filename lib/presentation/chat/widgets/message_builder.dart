import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MessageBuilder extends StatelessWidget {
  const MessageBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _MessageInput(),
          _SendButton(),
        ],
      ),
    );
  }
}

class _SendButton extends StatelessWidget {
  const _SendButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(50)),
      child: Icon(
        Ionicons.send,
        color: Colors.white,
      ),
    );
  }
}

class _MessageInput extends StatelessWidget {
  const _MessageInput({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(100)),
      child: TextFormField(
        cursorColor: Colors.white,
        style: TextStyle(color: Colors.white),
        maxLines: null,
        decoration: InputDecoration(
          hintText: "Say Hi",
          hintStyle: TextStyle(color: Colors.grey.shade300),
          border: InputBorder.none,
        ),
      ),
    ));
  }
}
