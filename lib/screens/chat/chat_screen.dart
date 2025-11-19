// chat_screen.dart
import 'package:flutter/material.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  late TabController _tabController;
  
  String _activeTab = 'chats';
  Map<String, dynamic>? _selectedChat;

  final List<Map<String, dynamic>> _chats = [
    {
      'id': 1,
      'user': 'Sarah L.',
      'lastMessage': 'Thanks for the support today! Feeling better already.',
      'time': '2 min',
      'unread': 2,
      'avatar': 'S',
      'avatarColor': const LinearGradient(colors: [Color(0xFFFF6B9D), Color(0xFFFFC371)]),
      'online': true,
    },
    {
      'id': 2,
      'user': 'Mike D.',
      'lastMessage': 'Hey, how was the meeting in the depression circle?',
      'time': '1h',
      'unread': 0,
      'avatar': 'M',
      'avatarColor': const LinearGradient(colors: [Color(0xFFFFA726), Color(0xFFFB8C00)]),
      'online': false,
    },
    {
      'id': 3,
      'user': 'Emma W.',
      'lastMessage': 'Let\'s schedule a voice session for anxiety relief.',
      'time': '3h',
      'unread': 1,
      'avatar': 'E',
      'avatarColor': const LinearGradient(colors: [Color(0xFF66CDAA), Color(0xFF20B2AA)]),
      'online': true,
    },
    {
      'id': 4,
      'user': 'John S.',
      'lastMessage': 'Shared my story about overcoming drugs - your turn?',
      'time': '1d',
      'unread': 0,
      'avatar': 'J',
      'avatarColor': const LinearGradient(colors: [Color(0xFF9575CD), Color(0xFF7E57C2)]),
      'online': false,
    },
  ];

  final List<Map<String, dynamic>> _doctors = [
    {
      'id': 1,
      'name': 'Dr. Sophie Martin',
      'specialty': 'Psychiatre',
      'avatar': 'SM',
      'avatarColor': const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)]),
      'rating': 4.9,
      'available': true,
      'nextAvailable': 'Disponible maintenant',
      'consultations': 234,
    },
    {
      'id': 2,
      'name': 'Dr. Ahmed Ben Ali',
      'specialty': 'Psychologue Clinicien',
      'avatar': 'AB',
      'avatarColor': const LinearGradient(colors: [Color(0xFF7E57C2), Color(0xFF9C27B0)]),
      'rating': 4.8,
      'available': false,
      'nextAvailable': 'Disponible à 15h',
      'consultations': 189,
    },
    {
      'id': 3,
      'name': 'Dr. Claire Dubois',
      'specialty': 'Thérapeute',
      'avatar': 'CD',
      'avatarColor': const LinearGradient(colors: [Color(0xFFEC407A), Color(0xFFE91E63)]),
      'rating': 4.9,
      'available': true,
      'nextAvailable': 'Disponible maintenant',
      'consultations': 312,
    },
    {
      'id': 4,
      'name': 'Dr. Karim Mansour',
      'specialty': 'Addictologue',
      'avatar': 'KM',
      'avatarColor': const LinearGradient(colors: [Color(0xFF66BB6A), Color(0xFF26A69A)]),
      'rating': 4.7,
      'available': true,
      'nextAvailable': 'Disponible maintenant',
      'consultations': 156,
    },
  ];

  final List<Map<String, dynamic>> _messages = [
    {'id': 1, 'text': 'Salut! Comment vas-tu aujourd\'hui?', 'sent': false, 'time': '10:30'},
    {'id': 2, 'text': 'Ça va mieux merci! La séance d\'hier m\'a vraiment aidé.', 'sent': true, 'time': '10:32'},
    {'id': 3, 'text': 'Super! Je suis content de l\'entendre 😊', 'sent': false, 'time': '10:33'},
    {'id': 4, 'text': 'Tu veux qu\'on en parle plus en détail?', 'sent': false, 'time': '10:33'},
    {'id': 5, 'text': 'Oui avec plaisir! J\'ai quelques questions', 'sent': true, 'time': '10:35'},
  ];

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
        'user': doctor['name'],
        'avatar': doctor['avatar'],
        'avatarColor': doctor['avatarColor'],
        'specialty': doctor['specialty'],
        'isDoctor': true,
        'available': doctor['available'],
        'online': doctor['available'],
      };
      _activeTab = 'chats';
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
            colors: [
              Color(0xFFE3F2FD),
              Color(0xFFF3E5F5),
              Color(0xFFFCE4EC),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildHeader(),
              Expanded(
                child: _activeTab == 'chats' ? _buildChatsList() : _buildDoctorsList(),
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
        color: Colors.white.withOpacity(0.8),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF5F5F5),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        hintText: 'Rechercher des conversations...',
                        prefixIcon: Icon(Icons.search, color: Color(0xFF9E9E9E)),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF42A5F5).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: IconButton(
                    onPressed: _showNewChatDialog,
                    icon: const Icon(Icons.add, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: _buildTabButton(
                    'chats',
                    'Messages',
                    Icons.chat_bubble_rounded,
                    const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)]),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildTabButton(
                    'doctors',
                    'Médecins',
                    Icons.medical_services_rounded,
                    const LinearGradient(colors: [Color(0xFF9C27B0), Color(0xFFE91E63)]),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTabButton(String tab, String label, IconData icon, Gradient gradient) {
    final isActive = _activeTab == tab;
    return GestureDetector(
      onTap: () => setState(() => _activeTab = tab),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          gradient: isActive ? gradient : null,
          color: isActive ? null : const Color(0xFFF5F5F5),
          borderRadius: BorderRadius.circular(25),
          boxShadow: isActive
              ? [BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 8, offset: const Offset(0, 4))]
              : [],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: isActive ? Colors.white : const Color(0xFF757575), size: 20),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: isActive ? Colors.white : const Color(0xFF757575),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        final chat = _chats[index];
        return GestureDetector(
          onTap: () => setState(() => _selectedChat = chat),
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.9),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white.withOpacity(0.5)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: 56,
                        height: 56,
                        decoration: BoxDecoration(
                          gradient: chat['avatarColor'],
                          shape: BoxShape.circle,
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
                            chat['avatar'],
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 22,
                            ),
                          ),
                        ),
                      ),
                      if (chat['online'])
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
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              chat['user'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF212121),
                              ),
                            ),
                            Text(
                              chat['time'],
                              style: const TextStyle(
                                fontSize: 12,
                                color: Color(0xFF9E9E9E),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          chat['lastMessage'],
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xFF757575),
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (chat['unread'] > 0) ...[
                    const SizedBox(width: 12),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF42A5F5).withOpacity(0.3),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: Text(
                        '${chat['unread']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildDoctorsList() {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF9C27B0), Color(0xFFE91E63)],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF9C27B0).withOpacity(0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              const Icon(Icons.medical_services_rounded, color: Colors.white, size: 32),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Consultez un médecin',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Des professionnels de santé disponibles pour vous accompagner',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        ..._doctors.map((doctor) => _buildDoctorCard(doctor)).toList(),
      ],
    );
  }

  Widget _buildDoctorCard(Map<String, dynamic> doctor) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withOpacity(0.5)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: doctor['avatarColor'],
                    shape: BoxShape.circle,
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
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
                if (doctor['available'])
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
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              doctor['name'],
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Color(0xFF212121),
                              ),
                            ),
                            Text(
                              doctor['specialty'],
                              style: const TextStyle(
                                fontSize: 13,
                                color: Color(0xFF757575),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF8E1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Color(0xFFFFC107), size: 14),
                            const SizedBox(width: 4),
                            Text(
                              '${doctor['rating']}',
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                color: Color(0xFFF57C00),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.access_time, size: 14, color: Color(0xFF9E9E9E)),
                      const SizedBox(width: 4),
                      Text(
                        doctor['nextAvailable'],
                        style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
                      ),
                      const SizedBox(width: 12),
                      const Text('•', style: TextStyle(color: Color(0xFF9E9E9E))),
                      const SizedBox(width: 12),
                      Text(
                        '${doctor['consultations']} consultations',
                        style: const TextStyle(fontSize: 12, color: Color(0xFF757575)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _startChatWithDoctor(doctor),
                          icon: const Icon(Icons.chat_bubble_rounded, size: 18),
                          label: const Text('Chat'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF42A5F5),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () {},
                          icon: const Icon(Icons.videocam_rounded, size: 18),
                          label: const Text('Appel'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF9C27B0),
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 10),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatInterface() {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFAFAFA), Color(0xFFE3F2FD)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          children: [
            _buildChatHeader(),
            Expanded(child: _buildMessagesList()),
            _buildMessageInput(),
          ],
        ),
      ),
    );
  }

  Widget _buildChatHeader() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () => setState(() => _selectedChat = null),
                icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF757575)),
              ),
              Stack(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: _selectedChat!['avatarColor'],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        _selectedChat!['avatar'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  if (_selectedChat!['online'])
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 14,
                        height: 14,
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
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          _selectedChat!['user'],
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            color: Color(0xFF212121),
                          ),
                        ),
                        if (_selectedChat!['isDoctor'] == true) ...[
                          const SizedBox(width: 6),
                          const Icon(Icons.medical_services_rounded, color: Color(0xFF42A5F5), size: 16),
                        ],
                      ],
                    ),
                    Text(
                      _selectedChat!['isDoctor'] == true
                          ? _selectedChat!['specialty']
                          : (_selectedChat!['online'] ? 'En ligne' : 'Hors ligne'),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF9E9E9E),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.phone, color: Color(0xFF757575)),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.videocam_rounded, color: Color(0xFF757575)),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Color(0xFF757575)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMessagesList() {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return Align(
          alignment: message['sent'] ? Alignment.centerRight : Alignment.centerLeft,
          child: Container(
            margin: const EdgeInsets.only(bottom: 12),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.7),
            decoration: BoxDecoration(
              gradient: message['sent']
                  ? const LinearGradient(colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)])
                  : null,
              color: message['sent'] ? null : Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 5,
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
                    color: message['sent'] ? Colors.white : const Color(0xFF212121),
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      message['time'],
                      style: TextStyle(
                        color: message['sent'] ? Colors.white70 : const Color(0xFF9E9E9E),
                        fontSize: 11,
                      ),
                    ),
                    if (message['sent']) ...[
                      const SizedBox(width: 4),
                      const Icon(Icons.done_all, color: Colors.white70, size: 14),
                    ],
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildMessageInput() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Colors.grey.shade200)),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.attach_file, color: Color(0xFF757575)),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F5F5),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TextField(
                    controller: _messageController,
                    decoration: const InputDecoration(
                      hintText: 'Écrivez votre message...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.emoji_emotions_outlined, color: Color(0xFF757575)),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF42A5F5), Color(0xFF26C6DA)],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF42A5F5).withOpacity(0.3),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: () {
                    if (_messageController.text.trim().isNotEmpty) {
                      // Envoyer le message
                      setState(() {
                        _messages.add({
                          'id': _messages.length + 1,
                          'text': _messageController.text,
                          'sent': true,
                          'time': '${DateTime.now().hour}:${DateTime.now().minute}',
                        });
                        _messageController.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.send, color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showNewChatDialog() {
    final newChatController = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Nouvelle conversation',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF212121),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F5),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: TextField(
                  controller: newChatController,
                  decoration: const InputDecoration(
                    hintText: 'Nom d\'utilisateur...',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(16),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        backgroundColor: const Color(0xFFF5F5F5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Annuler',
                        style: TextStyle(
                          color: Color(0xFF757575),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        if (newChatController.text.trim().isNotEmpty) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: const Text('Nouvelle conversation démarrée!'),
                              backgroundColor: const Color(0xFF66CDAA),
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF42A5F5),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text(
                        'Démarrer',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
}