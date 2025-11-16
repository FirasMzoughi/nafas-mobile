import 'package:flutter/material.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("القصص المجهولة")),
      body: const Center(child: Text("اكتب قصتك بأمان", style: TextStyle(fontSize: 20))),
    );
  }
}