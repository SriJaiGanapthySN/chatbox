import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;
  const ChatBubble(
      {super.key, required this.isCurrentUser, required this.message});

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: isCurrentUser ? Colors.blue : Colors.grey[800],
          borderRadius: BorderRadius.circular(12)),
      padding: EdgeInsets.all(width * 0.04),
      margin: EdgeInsets.symmetric(
          horizontal: width * 0.045, vertical: height * 0.005),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: width * 0.01),
        child: Text(
          message,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
