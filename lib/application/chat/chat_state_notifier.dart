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
    state = state.copyWith(
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
      createdAt: timestamp,
      reply: state.reply,
    );
    repository.sendMessage(newMessage);
    state = state.copyWith(reply: null);
  }

  void onMessageSelected(Message message) {
    state = state.copyWith(selected: message);
  }

  void clearSelected() {
    state = state.copyWith(selected: null);
  }

  void clearNewMessage() {
    state = state.copyWith(
      newMesage: null,
      reply: null,
    );
  }

  void reply() {
    state = state.copyWith(
      reply: state.selected?.message,
      selected: null,
    );
  }

  void reactToMessage(String reaction) {
    final message = state.selected!.copyWith(reaction: reaction);
    repository.sendMessage(message);
    state = state.copyWith(selected: null);
  }

  void cancelReply() {
    state = state.copyWith(
      reply: null,
      selected: null,
    );
  }
}
