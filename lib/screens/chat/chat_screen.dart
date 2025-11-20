// chat_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  late TabController _tabController;
  
  String _activeTab = 'groups';
  Map<String, dynamic>? _selectedChat;

  // GROUP CHATS - Support groups for mental health
  final List<Map<String, dynamic>> _groupChats = [
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
    {
      'id': 4,
      'name': 'Trauma Healing Community',
      'description': 'Healing from past experiences',
      'lastMessage': 'John: Your story inspired me to share mine',
      'time': '5h',
      'unread': 0,
      'icon': Icons.favorite_rounded,
      'color': const LinearGradient(colors: [Color(0xFFAB47BC), Color(0xFF9C27B0)]),
      'members': 34,
      'isActive': false,
      'category': 'Trauma',
    },
    {
      'id': 5,
      'name': 'Bipolar Support Network',
      'description': 'Living with bipolar disorder',
      'lastMessage': 'Lisa: Managing mood swings this week...',
      'time': '1d',
      'unread': 0,
      'icon': Icons.mood_rounded,
      'color': const LinearGradient(colors: [Color(0xFFFF7043), Color(0xFFFF5722)]),
      'members': 19,
      'isActive': true,
      'category': 'Bipolar',
    },
  ];

  // PROFESSIONAL DOCTORS
  final List<Map<String, dynamic>> _doctors = [
    {
      'id': 1,
      'name': 'Dr. Sophie Martin',
      'specialty': 'Psychiatrist - Depression & Anxiety',
      'avatar': 'SM',
      'avatarColor': const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)]),
      'rating': 4.9,
      'available': true,
      'nextAvailable': 'Available now',
      'consultations': 234,
      'languages': ['English', 'French', 'Arabic'],
      'experience': '12 years',
      'price': '\$80/session',
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
      'consultations': 189,
      'languages': ['Arabic', 'English'],
      'experience': '8 years',
      'price': '\$70/session',
    },
    {
      'id': 3,
      'name': 'Dr. Claire Dubois',
      'specialty': 'Therapist - Addiction Recovery',
      'avatar': 'CD',
      'avatarColor': const LinearGradient(colors: [Color(0xFFEC407A), Color(0xFFE91E63)]),
      'rating': 4.9,
      'available': true,
      'nextAvailable': 'Available now',
      'consultations': 312,
      'languages': ['French', 'English'],
      'experience': '15 years',
      'price': '\$90/session',
    },
    {
      'id': 4,
      'name': 'Dr. Karim Mansour',
      'specialty': 'Addiction Specialist',
      'avatar': 'KM',
      'avatarColor': const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF26A69A)]),
      'rating': 4.7,
      'available': true,
      'nextAvailable': 'Available now',
      'consultations': 156,
      'languages': ['Arabic', 'English', 'French'],
      'experience': '10 years',
      'price': '\$75/session',
    },
  ];

  // Sample group messages
  final List<Map<String, dynamic>> _groupMessages = [
    {'id': 1, 'user': 'Sarah L.', 'text': 'Hi everyone, having a tough day today 😔', 'sent': false, 'time': '10:30', 'isAnonymous': false},
    {'id': 2, 'user': 'You', 'text': 'We\'re here for you Sarah. What\'s going on?', 'sent': true, 'time': '10:32', 'isAnonymous': true},
    {'id': 3, 'user': 'Mike D.', 'text': 'Same here, the struggle is real today', 'sent': false, 'time': '10:33', 'isAnonymous': true},
    {'id': 4, 'user': 'Emma W.', 'text': 'Remember, one day at a time. We\'ve got this together 💚', 'sent': false, 'time': '10:35', 'isAnonymous': false},
  ];

  // Sample doctor messages
  final List<Map<String, dynamic>> _doctorMessages = [
    {'id': 1, 'text': 'Hello! How are you feeling today?', 'sent': false, 'time': '10:30', 'isDoctor': true},
    {'id': 2, 'text': 'I\'ve been struggling with anxiety lately', 'sent': true, 'time': '10:32', 'isDoctor': false},
    {'id': 3, 'text': 'I understand. Can you tell me more about when these feelings started?', 'sent': false, 'time': '10:33', 'isDoctor': true},
    {'id': 4, 'text': 'About two weeks ago, after a stressful event at work', 'sent': true, 'time': '10:35', 'isDoctor': false},
    {'id': 5, 'text': 'That\'s a common trigger. Let\'s work on some coping strategies together.', 'sent': false, 'time': '10:37', 'isDoctor': true},
  ];

  List<Map<String, dynamic>> _currentMessages = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _searchController.dispose();
    _messageController.dispose();
    _tabController.dispose();
    super.dispose();
  }

  void _startChatWithDoctor(Map<String, dynamic> doctor) {
    setState(() {
      _selectedChat = {
        'name': doctor['name'],
        'avatar': doctor['avatar'],
        'avatarColor': doctor['avatarColor'],
        'specialty': doctor['specialty'],
        'isDoctor': true,
        'isGroup': false,
        'available': doctor['available'],
        'online': doctor['available'],
      };
      _currentMessages = List.from(_doctorMessages);
      _activeTab = 'doctors';
    });
  }

  void _openGroupChat(Map<String, dynamic> group) {
    setState(() {
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
      _currentMessages = List.from(_groupMessages);
      _activeTab = 'groups';
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_selectedChat != null) {
      return _buildChatInterface();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE8F5F3), Color(0xFFB2F7EF)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _activeTab == 'groups' ? _buildGroupsList() : _buildDoctorsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Support & Care',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2F4F4F),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Connect with groups and professionals',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2D9B87), Color(0xFF26A69A)],
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2D9B87).withOpacity(0.3),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.help_outline_rounded, color: Colors.white),
                    tooltip: 'Help & Guidelines',
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            
            // Search bar
            Container(
              decoration: BoxDecoration(
                color: const Color(0xFFF5F9F8),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF2D9B87).withOpacity(0.2),
                  width: 1.5,
                ),
              ),
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search groups or doctors...',
                  hintStyle: TextStyle(color: Color(0xFFB0BEC5)),
                  prefixIcon: Icon(Icons.search_rounded, color: Color(0xFF2D9B87)),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                ),
              ),
            ),
            const SizedBox(height: 20),
            
            // Tabs
            Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    'groups',
                    'Support Groups',
                    Icons.groups_rounded,
                    const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF26A69A)]),
                    _groupChats.where((g) => g['unread'] > 0).length,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton(
                    'doctors',
                    'Professionals',
                    Icons.medical_services_rounded,
                    const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)]),
                    _doctors.where((d) => d['available']).length,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String tab, String label, IconData icon, Gradient gradient, int badge) {
    final isActive = _activeTab == tab;
    return GestureDetector(
      onTap: () {
        setState(() => _activeTab = tab);
        HapticFeedback.lightImpact();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          gradient: isActive ? gradient : null,
          color: isActive ? null : const Color(0xFFF5F9F8),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isActive
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  )
                ]
              : [],
          border: isActive ? null : Border.all(color: const Color(0xFF2D9B87).withOpacity(0.2)),
        ),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: isActive ? Colors.white : const Color(0xFF78909C),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isActive ? Colors.white : const Color(0xFF78909C),
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            if (badge > 0)
              Positioned(
                top: 0,
                right: 8,
                child: Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: isActive ? Colors.white : const Color(0xFFEF5350),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    '$badge',
                    style: TextStyle(
                      color: isActive ? const Color(0xFF2D9B87) : Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildGroupsList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Info banner
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF66BB6A), Color(0xFF26A69A)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF66BB6A).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.shield_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Safe & Anonymous',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Share your journey with people who understand. Your identity is protected.',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        
        // Groups list
        ..._groupChats.map((group) => _buildGroupCard(group)).toList(),
      ],
    );
  }

  Widget _buildGroupCard(Map<String, dynamic> group) {
    return GestureDetector(
      onTap: () => _openGroupChat(group),
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: group['isActive'] 
                ? const Color(0xFF2D9B87).withOpacity(0.3)
                : Colors.grey.withOpacity(0.2),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: [
              // Group Icon
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  gradient: group['color'],
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  group['icon'],
                  color: Colors.white,
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              
              // Group Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            group['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: Color(0xFF2F4F4F),
                            ),
                          ),
                        ),
                        if (group['isActive'])
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: const Color(0xFF4CAF50).withOpacity(0.3),
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: const [
                                Icon(Icons.circle, color: Color(0xFF4CAF50), size: 8),
                                SizedBox(width: 4),
                                Text(
                                  'Active',
                                  style: TextStyle(
                                    color: Color(0xFF4CAF50),
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      group['description'],
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.people_rounded, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 4),
                        Text(
                          '${group['members']} members',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Text('•', style: TextStyle(color: Color(0xFFB0BEC5))),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            group['lastMessage'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey[500],
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              
              // Unread badge or time
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (group['unread'] > 0)
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFFEF5350), Color(0xFFE53935)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFEF5350).withOpacity(0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        '${group['unread']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  const SizedBox(height: 8),
                  Text(
                    group['time'],
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDoctorsList() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        // Info banner
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF42A5F5).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.verified_user_rounded, color: Colors.white, size: 28),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Professional Care',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Licensed professionals ready to support your mental health journey',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        
        // Doctors list
        ..._doctors.map((doctor) => _buildDoctorCard(doctor)).toList(),
      ],
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: doctor['available']
              ? const Color(0xFF2D9B87).withOpacity(0.3)
              : Colors.grey.withOpacity(0.2),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // Doctor Avatar
                Stack(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        gradient: doctor['avatarColor'],
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          doctor['avatar'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    if (doctor['available'])
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 20,
                          height: 20,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 16),
                
                // Doctor Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              doctor['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF2F4F4F),
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFF8E1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(Icons.star_rounded, color: Color(0xFFFFC107), size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '${doctor['rating']}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: Color(0xFFF57C00),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        doctor['specialty'],
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[700],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.access_time_rounded, size: 14, color: Colors.grey[600]),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              doctor['nextAvailable'],
                              style: TextStyle(
                                fontSize: 12,
                                color: doctor['available']
                                    ? const Color(0xFF4CAF50)
                                    : Colors.grey[600],
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                          Text(
                            doctor['price'],
                            style: const TextStyle(
                              fontSize: 13,
                              color: Color(0xFF2D9B87),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Additional info
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                _buildInfoChip(Icons.work_outline_rounded, '${doctor['experience']} exp'),
                _buildInfoChip(Icons.chat_bubble_outline_rounded, '${doctor['consultations']} sessions'),
                ...doctor['languages'].take(2).map((lang) => 
                  _buildInfoChip(Icons.language_rounded, lang)
                ).toList(),
              ],
            ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _startChatWithDoctor(doctor),
                    icon: const Icon(Icons.chat_bubble_rounded, size: 18),
                    label: const Text('Start Chat'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2D9B87),
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Schedule consultation
                    },
                    icon: const Icon(Icons.videocam_rounded, size: 18),
                    label: const Text('Video Call'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF42A5F5),
                      side: const BorderSide(color: Color(0xFF42A5F5), width: 1.5),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F9F8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color(0xFF2D9B87).withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: const Color(0xFF2D9B87)),
          const SizedBox(width: 4),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF2F4F4F),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChatInterface() {
    final isGroup = _selectedChat!['isGroup'] == true;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFAFAFA), Color(0xFFE8F5F3)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildChatHeader(isGroup),
            Expanded(child: _buildMessagesList(isGroup)),
            _buildMessageInput(isGroup),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHeader(bool isGroup) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () => setState(() {
                  _selectedChat = null;
                  _currentMessages = [];
                }),
                icon: const Icon(Icons.arrow_back_ios_rounded, color: Color(0xFF2F4F4F)),
              ),
              
              // Avatar/Icon
              if (isGroup)
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    gradient: _selectedChat!['color'],
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(
                    _selectedChat!['icon'],
                    color: Colors.white,
                    size: 26,
                  ),
                )
              else
                Stack(
                  children: [
                    Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        gradient: _selectedChat!['avatarColor'],
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Center(
                        child: Text(
                          _selectedChat!['avatar'],
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                    if (_selectedChat!['online'])
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: const Color(0xFF4CAF50),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
              
              const SizedBox(width: 12),
              
              // Chat Info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Flexible(
                          child: Text(
                            _selectedChat!['name'],
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 17,
                              color: Color(0xFF2F4F4F),
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 6),
                        if (!isGroup)
                          const Icon(
                            Icons.verified_rounded,
                            color: Color(0xFF42A5F5),
                            size: 18,
                          ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      isGroup
                          ? '${_selectedChat!['members']} members • ${_selectedChat!['category']}'
                          : _selectedChat!['specialty'],
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              
              // Action buttons
              if (!isGroup) ...[
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone_rounded, color: Color(0xFF2D9B87)),
                  tooltip: 'Voice Call',
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.videocam_rounded, color: Color(0xFF2D9B87)),
                  tooltip: 'Video Call',
                ),
              ],
              IconButton(
                onPressed: () {
                  // Show group/chat info
                },
                icon: const Icon(Icons.info_outline_rounded, color: Color(0xFF78909C)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList(bool isGroup) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      reverse: false,
      itemCount: _currentMessages.length,
      itemBuilder: (context, index) {
        final message = _currentMessages[index];
        final isSent = message['sent'] == true;
        
        return Padding(
          padding: const EdgeInsets.only(bottom: 16),
          child: Row(
            mainAxisAlignment: isSent ? MainAxisAlignment.end : MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (!isSent && isGroup) ...[
                CircleAvatar(
                  radius: 18,
                  backgroundColor: const Color(0xFF2D9B87).withOpacity(0.2),
                  child: Text(
                    message['user'][0],
                    style: const TextStyle(
                      color: Color(0xFF2D9B87),
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
              
              Flexible(
                child: Column(
                  crossAxisAlignment: isSent ? CrossAxisAlignment.end : CrossAxisAlignment.start,
                  children: [
                    if (!isSent && isGroup)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4, left: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              message['user'],
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: Colors.grey[700],
                              ),
                            ),
                            if (message['isAnonymous'] == true) ...[
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF9E9E9E).withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: const [
                                    Icon(Icons.shield_rounded, size: 10, color: Color(0xFF9E9E9E)),
                                    SizedBox(width: 3),
                                    Text(
                                      'Anonymous',
                                      style: TextStyle(
                                        fontSize: 9,
                                        color: Color(0xFF9E9E9E),
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        gradient: isSent
                            ? const LinearGradient(
                                colors: [Color(0xFF2D9B87), Color(0xFF26A69A)],
                              )
                            : null,
                        color: isSent ? null : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            message['text'],
                            style: TextStyle(
                              color: isSent ? Colors.white : const Color(0xFF2F4F4F),
                              fontSize: 15,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                message['time'],
                                style: TextStyle(
                                  color: isSent ? Colors.white70 : Colors.grey[500],
                                  fontSize: 11,
                                ),
                              ),
                              if (isSent) ...[
                                const SizedBox(width: 4),
                                const Icon(Icons.done_all_rounded, color: Colors.white70, size: 14),
                              ],
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessageInput(bool isGroup) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {
                  // Attach file
                },
                icon: const Icon(Icons.attach_file_rounded, color: Color(0xFF78909C)),
                tooltip: 'Attach file',
              ),
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F9F8),
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                      color: const Color(0xFF2D9B87).withOpacity(0.2),
                    ),
                  ),
                  child: TextField(
                    controller: _messageController,
                    maxLines: null,
                    textCapitalization: TextCapitalization.sentences,
                    decoration: InputDecoration(
                      hintText: isGroup ? 'Message to group...' : 'Type your message...',
                      hintStyle: const TextStyle(color: Color(0xFFB0BEC5)),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions_outlined, color: Color(0xFF78909C)),
                tooltip: 'Emoji',
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF2D9B87), Color(0xFF26A69A)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2D9B87).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      setState(() {
                        _currentMessages.add({
                          'id': _currentMessages.length + 1,
                          'text': _messageController.text,
                          'sent': true,
                          'time': '${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}',
                          'user': 'You',
                        });
                        _messageController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.send_rounded, color: Colors.white),
                  tooltip: 'Send',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
