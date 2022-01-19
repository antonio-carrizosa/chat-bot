import 'dart:async';
import 'dart:math';
import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/repository/chat_repository.dart';
import 'package:uuid/uuid.dart';

class ChatImplementation implements ChatRepository {
  final _chatbot = User.chatbot;

  ChatImplementation() {
    _messageStream.add(
      Message(
          uid: Uuid().v4(),
          createdAt: DateTime.now().millisecondsSinceEpoch,
          message: "Hi there! \nHow can i help you?",
          sender: _chatbot.uid),
    );
    _botStream.add(_chatbot);
  }

  final List<String> _responses = [
    "Ok, lets see what can i do for you!",
    "Interesting...",
    "Ok, Tell me more!!",
    "Oh crabs!",
    "Sounds complicated.",
    "Have you tried restart the computer...",
    "Whats going on!!",
  ];

  StreamController<Message> _messageStream = StreamController<Message>();
  StreamController<User> _botStream = StreamController<User>();
  Timer? _replyTimer;
  bool initialized = false;

  @override
  Stream<User> onBotStateChange() => _botStream.stream;

  @override
  Stream<Message> onMessageReceived() => _messageStream.stream;

  @override
  void sendMessage(Message message) {
    _messageStream.add(message);
    Timer(Duration(seconds: _generateRandom(1, 2)), () {
      _messageStream.add(message.copyWith(readed: true));
      _botStream.sink.add(_chatbot.copyWith(isTyping: true));
    });
    _reply();
  }

  void _reply() {
    _replyTimer?.cancel();
    _replyTimer = Timer(Duration(seconds: _generateRandom(2, 5)), () {
      String? response;
      while (response == null) {
        response = _responses[_generateRandom(0, _responses.length - 1)];
      }
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _messageStream.add(
        Message(
            uid: Uuid().v4(),
            sender: _chatbot.uid,
            message: response,
            createdAt: timestamp),
      );
      _botStream.sink.add(_chatbot.copyWith(isTyping: false));
    });
  }

  _generateRandom(int min, int max) => min + Random().nextInt(max - min);

  @override
  void dispose() {
    _botStream.close();
    _messageStream.close();
  }
}
