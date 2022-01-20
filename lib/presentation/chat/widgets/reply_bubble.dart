import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class ReplyBubble extends StatelessWidget {
  const ReplyBubble({
    Key? key,
    required this.text,
    required this.cancel,
  }) : super(key: key);

  final String text;
  final void Function() cancel;

  @override
  Widget build(BuildContext context) {
    return SlideInUp(
      from: 10,
      duration: const Duration(milliseconds: 500),
      child: Container(
        margin: EdgeInsets.all(8),
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
            color: Colors.grey.shade600,
            borderRadius: BorderRadius.circular(25)),
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Expanded(
              child: Text(
                text,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            IconButton(
              onPressed: cancel,
              icon: Icon(
                Ionicons.close,
                color: Colors.white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
