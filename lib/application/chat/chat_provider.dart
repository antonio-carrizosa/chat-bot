import 'dart:async';
import 'dart:math';

import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/models/user.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {
  final List<String> responses = [
    "Ok, lets see what can i do for you!",
    "Interesting...",
    "Ok, Tell me more!!",
    "Oh crabs!",
    "Sounds complicated.",
    "Have you tried restart the computer...",
    "Whats going on!!",
  ];

  List<Message> _messages = [
    Message(
        createdAt: DateTime.now().millisecondsSinceEpoch,
        uid: User.chatbot.uid,
        message: "Hi there! \nHow can i help you?",
        sender: User.chatbot.uid)
  ];

  Timer? _timer;
  Timer? _readedTimer;

  List<Message> get messages => _messages;

  void sendMessage(Message message) {
    _messages = [..._messages, message];
    notifyListeners();

    _readedTimer =
        Timer(Duration(milliseconds: _generateRandom(1000, 2000)), () {
      _messages = [
        ..._messages.where((m) => m.uid != message.uid),
        message.copyWith(readed: true)
      ];
      notifyListeners();
    });

    _timer?.cancel();
    _timer = Timer(Duration(milliseconds: _generateRandom(2000, 5000)), () {
      final timestamp = DateTime.now().microsecondsSinceEpoch;
      final rnd = _generateRandom(0, _messages.length - 1);
      print(rnd);
      final message = responses[rnd];
      _messages = [
        ...messages,
        Message(
            uid: timestamp.toString(),
            createdAt: timestamp,
            sender: User.chatbot.uid,
            message: message)
      ];
      notifyListeners();
    });
  }

  _generateRandom(int min, int max) => min + Random().nextInt(max - min);

  @override
  void dispose() {
    _timer?.cancel();
    _readedTimer?.cancel();
    super.dispose();
  }
}
