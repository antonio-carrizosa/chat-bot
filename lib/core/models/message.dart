class Message {
  final String? uid;
  final String sender;
  final String message;
  final int createdAt;
  final bool readed;

  Message(
      {required this.uid,
      required this.sender,
      required this.message,
      required this.createdAt,
      this.readed = false});

  Message copyWith(
      {String? uid,
      String? sender,
      String? message,
      int? createdAt,
      bool? readed}) {
    return Message(
        uid: uid ?? this.uid,
        sender: sender ?? this.sender,
        message: message ?? this.message,
        readed: readed ?? this.readed,
        createdAt: createdAt ?? this.createdAt);
  }

  @override
  String toString() =>
      " Message: { uid: $uid, message: $message, sender: $sender  } ";
}
