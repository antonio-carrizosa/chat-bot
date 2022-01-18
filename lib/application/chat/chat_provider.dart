import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/core/repository/chat_repository.dart';
import 'package:chat_bot/core/repository/notification_repository.dart';
import 'package:flutter/cupertino.dart';

class ChatProvider with ChangeNotifier {
  final ChatRepository _chatRepository;
  final NotifycationRepository _notifycationRepository;
  final User _currentUser;

  ChatProvider(
      this._chatRepository, this._notifycationRepository, this._currentUser) {
    _chatRepository
      ..onMessageReceived().listen(_handleMessages)
      ..onBotStateChange().listen(handleBotState);
  }

  List<Message> _messages = [];
  List<Message> get messages => _messages;

  bool _isBotTyping = false;
  bool get isBotTyping => _isBotTyping;

  bool createNotification = false;

  void sendMessage(Message message) => _chatRepository.sendMessage(message);

  Future<void> _handleMessages(Message message) async {
    _messages = [..._messages.where((m) => m.uid != message.uid), message];
    notifyListeners();
    if (createNotification && message.sender != _currentUser.uid) {
      await _notifycationRepository.createNotification(
          '${message.sender} has sent a new message.', message.message);
    }
  }

  void handleBotState(User botUser) {
    _isBotTyping = botUser.isTyping;
    notifyListeners();
  }

  @override
  void dispose() {
    _chatRepository.dispose();
    super.dispose();
  }
}
