import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class AppBarContent extends StatelessWidget {
  final bool isTyping;

  const AppBarContent({Key? key, this.isTyping = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Row(
          children: [
            InkWell(
                onTap: () => Navigator.pop(context),
                child: Icon(Ionicons.arrow_back, color: Colors.white)),
            const SizedBox(width: 8),
            Icon(Ionicons.logo_octocat, color: Colors.white, size: 30),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("Chatbot",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold)),
                if (isTyping)
                  Text("Typing...",
                      style: TextStyle(color: Colors.white60, fontSize: 12)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
