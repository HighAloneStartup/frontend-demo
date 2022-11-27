import 'package:flutter/material.dart';
import './models/main_user.dart';

class DMPage extends StatefulWidget {
  final MainUser user;
  const DMPage({super.key, required this.user});

  @override
  State<DMPage> createState() => _DMPageState();
}

class _DMPageState extends State<DMPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: NewMessage(
          user: widget.user,
        ),
      ),
    );
  }
}

class NewMessage extends StatefulWidget {
  final MainUser user;

  const NewMessage({super.key, required this.user});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final newMessageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: newMessageController,
            decoration: InputDecoration(hintText: "New Message"),
          ),
        )
      ],
    );
  }
}
