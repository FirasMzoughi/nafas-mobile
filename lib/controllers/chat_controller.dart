import 'package:flutter/material.dart';

class ChatController extends ChangeNotifier {
  String _activeTab = 'groups';
  Map<String, dynamic>? _selectedChat;
  List<Map<String, dynamic>> _currentMessages = [];

  String get activeTab => _activeTab;
  Map<String, dynamic>? get selectedChat => _selectedChat;
  List<Map<String, dynamic>> get currentMessages => _currentMessages;

  // Mock data - in real app, this would come from a service
  final List<Map<String, dynamic>> groupChats = [
    {
      'id': 1,
      'name': 'Depression Support Circle',
      'description': 'Safe space for depression discussions',
      'lastMessage': 'Sarah: Thanks everyone for today\'s session...',
      'time': '5 min',
      'unread': 3,
      'icon': Icons.sentiment_dissatisfied_rounded,
      'color': const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF26A69A)]),
      'members': 45,
      'isActive': true,
      'category': 'Depression',
    },
    {
      'id': 2,
      'name': 'Addiction Recovery Group',
      'description': 'Overcoming drugs & alcohol together',
      'lastMessage': 'Mike: 30 days clean today! 🎉',
      'time': '1h',
      'unread': 0,
      'icon': Icons.local_hospital_rounded,
      'color': const LinearGradient(colors: [Color(0xFFEF5350), Color(0xFFE53935)]),
      'members': 28,
      'isActive': true,
      'category': 'Addiction',
    },
    {
      'id': 3,
      'name': 'Anxiety & Stress Relief',
      'description': 'Managing anxiety and panic attacks',
      'lastMessage': 'Emma: Breathing exercises really helped!',
      'time': '3h',
      'unread': 1,
      'icon': Icons.psychology_rounded,
      'color': const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)]),
      'members': 62,
      'isActive': true,
      'category': 'Anxiety',
    },
  ];

  final List<Map<String, dynamic>> doctors = [
    {
      'id': 1,
      'name': 'Dr. Sophie Martin',
      'specialty': 'Psychiatrist - Depression & Anxiety',
      'avatar': 'SM',
      'avatarColor': const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)]),
      'rating': 4.9,
      'available': true,
      'nextAvailable': 'Available now',
    },
    {
      'id': 2,
      'name': 'Dr. Ahmed Ben Ali',
      'specialty': 'Clinical Psychologist - Trauma',
      'avatar': 'AB',
      'avatarColor': const LinearGradient(colors: [Color(0xFF7E57C2), Color(0xFF9C27B0)]),
      'rating': 4.8,
      'available': false,
      'nextAvailable': 'Available at 3:00 PM',
    },
  ];

  void setActiveTab(String tab) {
    _activeTab = tab;
    notifyListeners();
  }

  void openGroupChat(Map<String, dynamic> group) {
    _selectedChat = {
      'name': group['name'],
      'icon': group['icon'],
      'color': group['color'],
      'description': group['description'],
      'members': group['members'],
      'isGroup': true,
      'isDoctor': false,
      'isActive': group['isActive'],
      'category': group['category'],
    };
    _currentMessages = [
      {'id': 1, 'user': 'Sarah L.', 'text': 'Hi everyone, having a tough day today 😔', 'sent': false, 'time': '10:30'},
      {'id': 2, 'user': 'You', 'text': 'We\'re here for you Sarah. What\'s going on?', 'sent': true, 'time': '10:32'},
    ];
    notifyListeners();
  }

  void startChatWithDoctor(Map<String, dynamic> doctor) {
    _selectedChat = {
      'name': doctor['name'],
      'avatar': doctor['avatar'],
      'avatarColor': doctor['avatarColor'],
      'specialty': doctor['specialty'],
      'isDoctor': true,
      'isGroup': false,
      'available': doctor['available'],
    };
    _currentMessages = [
      {'id': 1, 'text': 'Hello! How are you feeling today?', 'sent': false, 'time': '10:30'},
      {'id': 2, 'text': 'I\'ve been struggling with anxiety lately', 'sent': true, 'time': '10:32'},
    ];
    notifyListeners();
  }

  void closeChat() {
    _selectedChat = null;
    _currentMessages = [];
    notifyListeners();
  }

  void sendMessage(String text) {
    if (text.trim().isEmpty) return;
    
    _currentMessages.add({
      'id': _currentMessages.length + 1,
      'text': text,
      'sent': true,
      'time': 'Now',
    });
    notifyListeners();
  }
}
