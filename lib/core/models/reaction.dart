import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Reaction {
  static const String SO_SAD = "sad";
  static const String LIKE = "like";
  static const String HEART = "heart";

  static const reactions = [LIKE, SO_SAD, HEART];

  static IconData getReactionIcon(String reaction) {
    switch (reaction) {
      case Reaction.SO_SAD:
        return Ionicons.sad;
      case Reaction.LIKE:
        return Ionicons.thumbs_up;
      case Reaction.HEART:
        return Ionicons.heart;
      default:
        return Ionicons.help_outline;
    }
  }

  static Color getReactionColor(String reaction) {
    switch (reaction) {
      case Reaction.SO_SAD:
        return Colors.yellow;
      case Reaction.LIKE:
        return Colors.orange;
      case Reaction.HEART:
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
