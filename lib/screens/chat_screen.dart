import 'package:flutter/material.dart';
import '../widgets/custom_app_bar.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE7E4E2),
      appBar: const CustomAppBar(),
      body: const Center(child: Text('채팅')),
    );
  }
}
