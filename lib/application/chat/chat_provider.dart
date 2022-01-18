import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/repository/chat_repository.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {
  final ChatRepository _chatRepository;

  ChatProvider(this._chatRepository) {
    _chatRepository
      ..onMessageReceived().listen(_handleMessages)
      ..onBotStateChange().listen((botUser) {
        _isBotTyping = botUser.isTyping;
        notifyListeners();
      });
  }

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  bool _isBotTyping = false;
  bool get isBotTyping => _isBotTyping;

  bool createNotification = false;

  void sendMessage(Message message) => _chatRepository.sendMessage(message);

  void _handleMessages(Message message) {
    _messages = [..._messages.where((m) => m.uid != message.uid), message];
    notifyListeners();
  }

  @override
  void dispose() {
    _chatRepository.dispose();
    super.dispose();
  }
}
