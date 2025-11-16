import 'package:flutter/material.dart';

class TherapyScreen extends StatelessWidget {
  const TherapyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("العلاج والمساعدة الذاتية")),
      body: const Center(child: Text("تمارين التنفس وCBT", style: TextStyle(fontSize: 20))),
    );
  }
}