// chat_screen.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _searchController = TextEditingController();
  final List<Map<String, dynamic>> _chats = [
    {
      'user': 'Sarah L.',
      'lastMessage': 'Thanks for the support today! Feeling better already.',
      'time': '2 min ago',
      'unread': 2,
      'avatarColor': const Color(0xFFFF6B6B),
    },
    {
      'user': 'Mike D.',
      'lastMessage': 'Hey, how was the meeting in the depression circle?',
      'time': '1 hour ago',
      'unread': 0,
      'avatarColor': const Color(0xFFFFA726),
    },
    {
      'user': 'Emma W.',
      'lastMessage': 'Let\'s schedule a voice session for anxiety relief.',
      'time': '3 hours ago',
      'unread': 1,
      'avatarColor': const Color(0xFF66CDAA),
    },
    {
      'user': 'John S.',
      'lastMessage': 'Shared my story about overcoming drugs - your turn?',
      'time': 'Yesterday',
      'unread': 0,
      'avatarColor': const Color(0xFF9575CD),
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search chats...',
                      prefixIcon: const Icon(Icons.search, color: Color(0xFF66CDAA)),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                FloatingActionButton(
                  onPressed: () {
                    // Open new chat
                    _showNewChatDialog();
                  },
                  mini: true,
                  backgroundColor: const Color(0xFF66CDAA),
                  child: const Icon(Icons.add, color: Colors.white),
                ),
              ],
            ),
          ),
          // Chats List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: _chats.length,
              itemBuilder: (context, index) {
                final chat = _chats[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 15),
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  color: Colors.white.withOpacity(0.9),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: chat['avatarColor'],
                      child: Text(chat['user'][0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    ),
                    title: Text(
                      chat['user'],
                      style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
                    ),
                    subtitle: Text(
                      chat['lastMessage'],
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          chat['time'],
                          style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        ),
                        if (chat['unread'] > 0)
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF66CDAA),
                              shape: BoxShape.circle,
                            ),
                            child: Text(
                              '${chat['unread']}',
                              style: const TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold),
                            ),
                          ),
                      ],
                    ),
                    onTap: () {
                      // Open chat
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Opening chat with ${chat['user']}'), backgroundColor: const Color(0xFF66CDAA)),
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

  void _showNewChatDialog() {
    final _newChatController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text('Start New Chat', style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F))),
        content: TextField(
          controller: _newChatController,
          decoration: InputDecoration(
            hintText: 'Enter username...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (_newChatController.text.trim().isNotEmpty) {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('New chat started!'), backgroundColor: Color(0xFF66CDAA)),
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: const Color(0xFF66CDAA)),
            child: const Text('Start', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}