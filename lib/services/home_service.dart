import 'package:flutter/material.dart';

class HomeService {
  Future<List<Map<String, dynamic>>> getVoiceRooms() async {
    await Future.delayed(const Duration(milliseconds: 800)); // Simulate network
    return [
      {
        'title': 'Overcoming Drugs',
        'icon': Icons.local_hospital_rounded,
        'participants': 12,
        'color': const Color(0xFFEF5350),
        'isLive': true,
      },
      {
        'title': 'Alcohol Support',
        'icon': Icons.local_bar_rounded,
        'participants': 8,
        'color': const Color(0xFFFF7043),
        'isLive': true,
      },
      {
        'title': 'Depression Circle',
        'icon': Icons.sentiment_dissatisfied_rounded,
        'participants': 20,
        'color': const Color(0xFF66BB6A),
        'isLive': true,
      },
      {
        'title': 'Anxiety Relief',
        'icon': Icons.psychology_rounded,
        'participants': 15,
        'color': const Color(0xFF42A5F5),
        'isLive': false,
      },
      {
        'title': 'Healing Together',
        'icon': Icons.favorite_rounded,
        'participants': 10,
        'color': const Color(0xFFAB47BC),
        'isLive': true,
      },
    ];
  }

  Future<List<Map<String, dynamic>>> getPosts() async {
    await Future.delayed(const Duration(milliseconds: 1200)); // Simulate network
    return [
      {
        'user': 'Anonymous User',
        'timeAgo': '2h ago',
        'content':
            'Today was tough, but talking about my struggles with depression here helped me feel less alone. Grateful for this community. 💚',
        'likes': 45,
        'comments': 12,
        'isLiked': false,
        'category': 'Depression',
      },
      {
        'user': 'Anonymous User',
        'timeAgo': '5h ago',
        'content':
            'Quit smoking after years of trying. Joined the drugs room and it changed everything. Who\'s with me? 🌱',
        'likes': 23,
        'comments': 5,
        'isLiked': false,
        'category': 'Recovery',
      },
      {
        'user': 'Anonymous User',
        'timeAgo': '1d ago',
        'content':
            'Feeling overwhelmed by work and anxiety. Needed to vent. If you\'re reading this, you\'re not alone. Let\'s chat in the rooms. 🫂',
        'likes': 67,
        'comments': 18,
        'isLiked': false,
        'category': 'Anxiety',
      },
    ];
  }
}
