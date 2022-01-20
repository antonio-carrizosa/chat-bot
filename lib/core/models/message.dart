class Message {
  final String? uid;
  final String sender;
  final String message;
  final int createdAt;
  final bool readed;
  final String? reply;
  final String? reaction;

  Message(
      {required this.uid,
      required this.sender,
      required this.message,
      required this.createdAt,
      this.reply,
      this.reaction,
      this.readed = false});

  Message copyWith(
      {String? uid,
      String? sender,
      String? message,
      int? createdAt,
      bool? readed,
      String? reply,
      String? reaction}) {
    return Message(
        uid: uid ?? this.uid,
        sender: sender ?? this.sender,
        message: message ?? this.message,
        readed: readed ?? this.readed,
        createdAt: createdAt ?? this.createdAt,
        reply: reply ?? this.reply,
        reaction: reaction ?? this.reaction);
  }

  @override
  String toString() =>
      " Message: { uid: $uid, message: $message, sender: $sender  } ";
}
