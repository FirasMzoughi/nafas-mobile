import 'package:flutter/material.dart';

class NotificationsController extends ChangeNotifier {
  List<Map<String, dynamic>> _notifications = [
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
  ];

  List<Map<String, dynamic>> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => n['isRead'] == false).length;

  void markAsRead(Map<String, dynamic> notification) {
    notification['isRead'] = true;
    notifyListeners();
  }

  void markAllAsRead() {
    for (var notif in _notifications) {
      notif['isRead'] = true;
    }
    notifyListeners();
  }

  void removeNotification(Map<String, dynamic> notification) {
    _notifications.remove(notification);
    notifyListeners();
  }

  void restoreNotification(Map<String, dynamic> notification) {
    _notifications.add(notification);
    notifyListeners();
  }
}
