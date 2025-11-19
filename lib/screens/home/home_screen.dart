import 'package:flutter/material.dart';
import 'package:malath/screens/chat/chat_screen.dart';
import 'package:malath/screens/notifications/notifications_screen.dart';
import 'package:malath/screens/profile/profile_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const HomeTab(), // Home tab content
    const ChatScreen(),
    const NotificationsScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFB2F7EF), Color(0xFF66CDAA)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        selectedItemColor: const Color(0xFF66CDAA),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.white.withOpacity(0.9),
        elevation: 10,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat_outlined),
            activeIcon: Icon(Icons.chat),
            label: 'Chat',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications_outlined),
            activeIcon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
      floatingActionButton: _currentIndex == 0
          ? FloatingActionButton(
              onPressed: _showCreatePostDialog,
              backgroundColor: const Color(0xFF66CDAA),
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
    );
  }

  void _showCreatePostDialog() {
    final postController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Share Your Story',
          style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
        ),
        content: TextField(
          controller: postController,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: 'Write your feelings, story, or what happened...',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: const BorderSide(color: Color(0xFF66CDAA)),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              if (postController.text.trim().isNotEmpty) {
                // Simulate adding post (in real app, call API)
                setState(() {
                  // Add to a local list or refresh
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Story shared!'),
                    backgroundColor: Color(0xFF66CDAA),
                  ),
                );
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF66CDAA),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            ),
            child: const Text('Share', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final List<Map<String, dynamic>> _voiceRooms = [
    {'title': 'Overcoming Drugs', 'icon': Icons.local_hospital, 'participants': 12, 'color': const Color(0xFFFF6B6B)},
    {'title': 'Alcohol Support', 'icon': Icons.local_bar, 'participants': 8, 'color': const Color(0xFFFFA726)},
    {'title': 'Depression Circle', 'icon': Icons.mood_bad, 'participants': 20, 'color': const Color(0xFF66CDAA)},
    {'title': 'Sadness & Healing', 'icon': Icons.sentiment_very_dissatisfied, 'participants': 15, 'color': const Color(0xFF9575CD)},
    {'title': 'Anxiety Relief', 'icon': Icons.psychology, 'participants': 10, 'color': const Color(0xFF26C6DA)},
  ];

  final List<Map<String, dynamic>> _posts = [
    {
      'user': 'Sarah L.',
      'content': 'Today was tough, but talking about my struggles with depression here helped me feel less alone. Grateful for this community. 💚',
      'likes': 45,
      'comments': 12,
    },
    {
      'user': 'Mike D.',
      'content': 'Quit smoking after years of trying. Joined the drugs room and it changed everything. Who\'s with me?',
      'likes': 23,
      'comments': 5,
    },
    {
      'user': 'Emma W.',
      'content': 'Feeling overwhelmed by work and anxiety. Needed to vent. If you\'re reading this, you\'re not alone. Let\'s chat in the rooms.',
      'likes': 67,
      'comments': 18,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Welcome Back!',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
          ),
          const SizedBox(height: 10),
          const Text(
            'Find support and share your journey.',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
          const SizedBox(height: 30),

          // Voice Rooms Section
          const Text(
            'Voice Rooms',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 140, // Increased height to accommodate content without overflow
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _voiceRooms.length,
              itemBuilder: (context, index) {
                final room = _voiceRooms[index];
                return Container(
                  margin: const EdgeInsets.only(right: 15),
                  width: 160,
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    color: room['color'].withOpacity(0.1),
                    child: Padding(
                      padding: const EdgeInsets.all(12), // Reduced padding slightly
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // Use spaceBetween instead of Spacer for better distribution
                        children: [
                          Icon(room['icon'], color: room['color'], size: 28), // Slightly smaller icon
                          const SizedBox(height: 4),
                          Text(
                            room['title'],
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13), // Smaller font
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text('${room['participants']} people', style: const TextStyle(fontSize: 12, color: Colors.grey)),
                          SizedBox(
                            width: double.infinity,
                            height: 28, // Fixed smaller height for button
                            child: ElevatedButton(
                              onPressed: () {
                                // Navigate to voice room (simulate)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Joined ${room['title']}'), backgroundColor: room['color']),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: room['color'],
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                padding: EdgeInsets.zero, // Remove default padding
                                minimumSize: const Size(0, 0), // Override min size
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: const Text('Join', style: TextStyle(fontSize: 11, color: Colors.white)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 30),

          // Posts Section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Stories & Shares',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
              ),
              TextButton.icon(
                onPressed: () {
                  // Simulate refresh or load more
                  setState(() {});
                },
                icon: const Icon(Icons.refresh, size: 16),
                label: const Text('Refresh'),
              ),
            ],
          ),
          const SizedBox(height: 15),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _posts.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final post = _posts[index];
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white.withOpacity(0.9),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundColor: const Color(0xFF66CDAA),
                            radius: 18, // Smaller avatar
                            child: Text(post['user'][0], style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              post['user'],
                              style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
                              overflow: TextOverflow.ellipsis, // Prevent overflow
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(
                        post['content'],
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded( // Wrap inner row in Expanded to prevent right overflow
                            child: Row(
                              children: [
                                IconButton(
                                  onPressed: () {
                                    // Toggle like (simulate)
                                    setState(() {
                                      post['likes'] = post['likes'] + 1;
                                    });
                                  },
                                  icon: const Icon(Icons.favorite_border, color: Colors.red, size: 20),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                  tooltip: 'Heart',
                                ),
                                Flexible( // Flexible for text to wrap/shrink
                                  child: Text('${post['likes']} hearts', overflow: TextOverflow.ellipsis),
                                ),
                                const SizedBox(width: 16),
                                IconButton(
                                  onPressed: () {
                                    // Open comments (simulate dialog)
                                    _showCommentsDialog(context, post['comments']);
                                  },
                                  icon: const Icon(Icons.comment_outlined, color: Color(0xFF66CDAA), size: 20),
                                  padding: EdgeInsets.zero,
                                  constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
                                  tooltip: 'Comment',
                                ),
                                Flexible(
                                  child: Text('${post['comments']} comments', overflow: TextOverflow.ellipsis),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          TextButton(
                            onPressed: () {
                              // Share or something
                            },
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            ),
                            child: const Text('❤️ Support', style: TextStyle(color: Color(0xFF66CDAA), fontSize: 12)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: 20), // Extra space at bottom for better scrolling
        ],
      ),
    );
  }

  void _showCommentsDialog(BuildContext context, int commentCount) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Comments'),
        content: const Text('Comments section - add your thoughts here! (Simulated)'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}