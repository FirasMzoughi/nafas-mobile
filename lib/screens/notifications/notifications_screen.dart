// notifications_screen.dart
import 'package:flutter/material.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'heart',
      'title': 'Sarah L. hearted your story',
      'subtitle': '2 minutes ago',
      'icon': Icons.favorite,
      'color': const Color(0xFFFF6B6B),
    },
    {
      'type': 'comment',
      'title': 'Mike D. commented on your post',
      'subtitle': '1 hour ago',
      'icon': Icons.comment,
      'color': const Color(0xFFFFA726),
    },
    {
      'type': 'join',
      'title': 'New member joined Depression Circle',
      'subtitle': '3 hours ago',
      'icon': Icons.group_add,
      'color': const Color(0xFF66CDAA),
    },
    {
      'type': 'message',
      'title': 'Emma W. sent you a message',
      'subtitle': 'Yesterday',
      'icon': Icons.message,
      'color': const Color(0xFF9575CD),
    },
    {
      'type': 'room',
      'title': 'Anxiety Relief room is now active',
      'subtitle': '2 days ago',
      'icon': Icons.mic,
      'color': const Color(0xFF26C6DA),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFB2F7EF), Color(0xFF66CDAA)],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          // App Bar
          Container(
            padding: const EdgeInsets.all(20),
            child: const Row(
              children: [
                Expanded(
                  child: Text(
                    'Notifications',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
                  ),
                ),
                Icon(Icons.more_vert, color: Color(0xFF66CDAA)),
              ],
            ),
          ),
          // Notifications List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notif = _notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  elevation: 3,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: notif['color'].withOpacity(0.2),
                      child: Icon(notif['icon'], color: notif['color']),
                    ),
                    title: Text(
                      notif['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
                    ),
                    subtitle: Text(notif['subtitle'], style: TextStyle(color: Colors.grey[600])),
                    trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
                    onTap: () {
                      // Handle notification tap
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opened ${notif['title']}'), backgroundColor: notif['color']),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}