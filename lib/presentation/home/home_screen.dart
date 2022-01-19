import 'package:chat_bot/presentation/chat/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        elevation: 0,
        centerTitle: false,
        title: Text(
          'ChatBot',
          style: TextStyle(
            fontSize: 30,
          ),
        ),
      ),
      body: _Content(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pushNamedAndRemoveUntil(
            context, ChatScreen.routeName, (route) => route.isFirst),
        isExtended: true,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(Ionicons.chatbubbles_outline, size: 35),
        ),
      ),
    );
  }
}

class _Content extends StatelessWidget {
  const _Content({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SvgPicture.asset(
                "assets/svg/undraw_chatting_re_j55r.svg",
                width: MediaQuery.of(context).size.width * 0.9,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 16),
              Text(
                "Subtitle",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              ),
              const SizedBox(height: 8),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                textAlign: TextAlign.justify,
              ),
              const SizedBox(height: 8),
              SvgPicture.asset(
                "assets/svg/undraw_share_opinion_re_4qk7.svg",
                width: MediaQuery.of(context).size.width * 0.9,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 8),
              Text(
                "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
