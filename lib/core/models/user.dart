class User {
  static final User chatbot = User(uid: 'R2D2', name: 'chatbot', isBot: true);

  final String uid;
  final String name;
  final bool isBot;

  User({required this.uid, required this.name, this.isBot = false});
}
