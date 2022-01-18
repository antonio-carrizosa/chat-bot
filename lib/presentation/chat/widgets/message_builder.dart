import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class MessageBuilder extends StatefulWidget {
  final void Function(String msg) onMessage;

  const MessageBuilder({Key? key, required this.onMessage}) : super(key: key);

  @override
  _MessageBuilderState createState() => _MessageBuilderState();
}

class _MessageBuilderState extends State<MessageBuilder> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void sendMessage(String msg) {
    if (msg.isNotEmpty) {
      widget.onMessage(msg);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _MessageInput(controller: _controller),
          _SendButton(
            onPressed: () => sendMessage(_controller.text.trim()),
          ),
        ],
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
