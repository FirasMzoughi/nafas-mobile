import 'package:flutter/material.dart';

class VoiceRoomsScreen extends StatelessWidget {
  const VoiceRoomsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("قاعات صوتية")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(leading: Icon(Icons.mic), title: Text("غرفة الاكتئاب")),
          ListTile(leading: Icon(Icons.mic), title: Text("غرفة القلق")),
        ],
      ),
    );
  }
}