class User {
  final String uid;
  final String name;
  final bool isBot;
  final bool isTyping;

  User(
      {required this.uid,
      required this.name,
      this.isBot = false,
      this.isTyping = false});

  User copyWith({String? uid, String? name, bool? isBot, bool? isTyping}) =>
      User(
          uid: uid ?? this.uid,
          name: name ?? this.name,
          isBot: isBot ?? this.isBot,
          isTyping: isTyping ?? this.isTyping);
}
