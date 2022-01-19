import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/core/repository/chat_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BotStateNotifier extends StateNotifier<User> {
  ChatRepository _repository;
  BotStateNotifier(this._repository) : super(User.chatbot) {
    _repository.onBotStateChange().listen((bot) {
      state = bot;
    });
  }
}
