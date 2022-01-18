import 'dart:async';
import 'dart:math';
import 'package:chat_bot/core/models/user.dart';
import 'package:chat_bot/core/models/message.dart';
import 'package:chat_bot/core/repository/chat_repository.dart';

class ChatImplementation implements ChatRepository {
  final _chatbot = User(uid: 'R2D2', name: 'chatbot', isBot: true);

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

  ChatImplementation() {
    _botStream.sink.add(_chatbot);

    _messageStream.add(
      Message(
          createdAt: DateTime.now().millisecondsSinceEpoch,
          uid: _chatbot.uid,
          message: "Hi there! \nHow can i help you?",
          sender: _chatbot.uid),
    );
  }

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
    _getReply();
  }

  void _getReply() {
    _replyTimer?.cancel();
    _replyTimer = Timer(Duration(seconds: _generateRandom(2, 5)), () {
      String? response;
      while (response == null) {
        response = _responses[_generateRandom(0, _responses.length - 1)];
      }
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      _messageStream.add(Message(
          uid: timestamp.toString(),
          sender: _chatbot.uid,
          message: response,
          createdAt: timestamp));
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