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
      'id': '1',
      'type': 'heart',
      'title': 'Sarah L. sent you support',
      'message': 'Your story "My journey with anxiety" received a heart',
      'time': '2 min ago',
      'icon': Icons.favorite_rounded,
      'color': const Color(0xFFFF6B6B),
      'isRead': false,
    },
    {
      'id': '2',
      'type': 'doctor',
      'title': 'Dr. Sophie Martin confirmed',
      'message': 'Your appointment is scheduled for tomorrow at 10:00 AM',
      'time': '1 hour ago',
      'icon': Icons.calendar_today_rounded,
      'color': const Color(0xFF42A5F5),
      'isRead': false,
    },
    {
      'id': '3',
      'type': 'group',
      'title': 'Depression Circle is active',
      'message': '5 new members joined the conversation. Join now!',
      'time': '3 hours ago',
      'icon': Icons.groups_rounded,
      'color': const Color(0xFF66CDAA),
      'isRead': true,
    },
    {
      'id': '4',
      'type': 'message',
      'title': 'New message from Emma W.',
      'message': 'Hey! I just wanted to check in on you...',
      'time': 'Yesterday',
      'icon': Icons.chat_bubble_rounded,
      'color': const Color(0xFF9575CD),
      'isRead': true,
    },
    {
      'id': '5',
      'type': 'system',
      'title': 'Weekly Wellness Report',
      'message': 'Your mood tracking summary is ready to view',
      'time': '2 days ago',
      'icon': Icons.insert_chart_rounded,
      'color': const Color(0xFFFFA726),
      'isRead': true,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F9F8),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Notifications',
          style: TextStyle(
            color: Color(0xFF2F4F4F),
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        actions: [
          IconButton(
            onPressed: _markAllAsRead,
            icon: const Icon(Icons.done_all_rounded, color: Color(0xFF2D9B87)),
            tooltip: 'Mark all as read',
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: _notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              // We will render items directly based on list length for safety
              itemCount: _notifications.length,
              itemBuilder: (context, index) {
                final notif = _notifications[index];
                // Simple logic to add headers visually without complex index math
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (index == 0) _buildHeader('Today'),
                    if (index == 3) _buildHeader('Yesterday'),
                    if (index == 4) _buildHeader('Older'),
                    _buildNotificationCard(notif),
                  ],
                );
              },
            ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 16, 4, 12),
      child: Text(
        title,
        style: TextStyle(
          color: Colors.grey[600],
          fontWeight: FontWeight.bold,
          fontSize: 14,
          letterSpacing: 0.5,
        ),
      ),
    );
  }

  Widget _buildNotificationCard(Map<String, dynamic> notif) {
    // Safety check: ensure ID exists and is a string
    final String id = notif['id']?.toString() ?? DateTime.now().toString(); 
    final bool isRead = notif['isRead'] ?? false;
    final Color color = notif['color'] ?? Colors.grey;

    return Dismissible(
      key: Key(id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFFEF5350),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
      ),
      onDismissed: (direction) {
        setState(() {
          _notifications.remove(notif);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Notification cleared'),
            action: SnackBarAction(
              label: 'Undo',
              textColor: const Color(0xFF66CDAA),
              onPressed: () {
                setState(() {
                   _notifications.add(notif); 
                   // Note: simplified re-add
                });
              },
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: isRead ? Colors.white : const Color(0xFFF0FDF9),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: isRead ? Colors.transparent : const Color(0xFF2D9B87).withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              setState(() {
                notif['isRead'] = true;
              });
            },
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Icon
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: color.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(notif['icon'], color: color, size: 22),
                  ),
                  const SizedBox(width: 16),
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                notif['title'] ?? 'Notification',
                                style: TextStyle(
                                  fontWeight: isRead ? FontWeight.w600 : FontWeight.bold,
                                  fontSize: 15,
                                  color: const Color(0xFF2F4F4F),
                                ),
                              ),
                            ),
                            if (!isRead)
                              Container(
                                margin: const EdgeInsets.only(left: 8),
                                width: 8,
                                height: 8,
                                decoration: const BoxDecoration(
                                  color: Color(0xFF2D9B87),
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          notif['message'] ?? '',
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13,
                            height: 1.4,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          notif['time'] ?? '',
                          style: TextStyle(
                            color: Colors.grey[400],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: const BoxDecoration(
              color: Color(0xFFE0F2F1),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.notifications_none_rounded,
              size: 64,
              color: Color(0xFF2D9B87),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'All Caught Up!',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2F4F4F),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'You have no new notifications at the moment.',
            style: TextStyle(
              color: Colors.grey[600],
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  void _markAllAsRead() {
    setState(() {
      for (var notif in _notifications) {
        notif['isRead'] = true;
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('All notifications marked as read'),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Color(0xFF2D9B87),
      ),
    );
  }
}
