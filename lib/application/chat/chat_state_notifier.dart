import 'package:chat_bot/application/chat/chat_state.dart';
import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class ChatStateNotifier extends StateNotifier<ChatState> {
  final ChatRepository repository;

  ChatStateNotifier(this.repository) : super(ChatState(messages: [])) {
    repository.onMessageReceived().listen(_handleMessages);
  }

  void _handleMessages(Message message) {
    state = state.coptyWith(
      messages: [...state.messages.where((m) => m.uid != message.uid), message],
      newMesage: message,
    );
  }

  void sendMessage(String message, String sender) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final newMessage = Message(
        uid: Uuid().v4(),
        sender: sender,
        message: message,
        createdAt: timestamp);
    repository.sendMessage(newMessage);
  }

  void clearNewMessage() {
    state = state.coptyWith(newMesage: null);
  }
}
