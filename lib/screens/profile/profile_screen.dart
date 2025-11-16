// profile_screen.dart
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  final TextEditingController _bioController = TextEditingController(text: 'On a journey to better mental health. Grateful for this community. 💚');

  @override
  void dispose() {
    _bioController.dispose();
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                Positioned(
                  top: 50,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: const Color(0xFF66CDAA),
                    child: const Icon(Icons.person, size: 60, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              'Your Name',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
            ),
            const SizedBox(height: 5),
            Text(
              _isEditing
                  ? ''
                  : '@username',
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
            const SizedBox(height: 20),

            // Edit Bio Section
            Card(
              elevation: 5,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white.withOpacity(0.9),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Bio',
                          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Color(0xFF2F4F4F)),
                        ),
                        IconButton(
                          onPressed: () => setState(() => _isEditing = !_isEditing),
                          icon: Icon(_isEditing ? Icons.save : Icons.edit, color: const Color(0xFF66CDAA)),
                        ),
                      ],
                    ),
                    if (_isEditing)
                      TextField(
                        controller: _bioController,
                        maxLines: 3,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                          hintText: 'Tell us about yourself...',
                        ),
                        onSubmitted: (_) => setState(() => _isEditing = false),
                      )
                    else
                      Text(
                        _bioController.text,
                        style: const TextStyle(fontSize: 16, height: 1.5),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Stats Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _StatCard(icon: Icons.favorite, label: 'Hearts', value: '127'),
                _StatCard(icon: Icons.comment, label: 'Comments', value: '45'),
                _StatCard(icon: Icons.mic, label: 'Rooms Joined', value: '8'),
              ],
            ),
            const SizedBox(height: 20),

            // Settings Buttons
            ElevatedButton.icon(
              onPressed: () {
                // Edit profile
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Edit profile'), backgroundColor: Color(0xFF66CDAA)),
                );
              },
              icon: const Icon(Icons.edit),
              label: const Text('Edit Profile'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF66CDAA),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
            const SizedBox(height: 10),
            OutlinedButton.icon(
              onPressed: () {
                // Settings
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Settings'), backgroundColor: Color(0xFF66CDAA)),
                );
              },
              icon: const Icon(Icons.settings),
              label: const Text('Settings'),
              style: OutlinedButton.styleFrom(
                side: const BorderSide(color: Color(0xFF66CDAA)),
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: const Color(0xFF66CDAA), size: 30),
        const SizedBox(height: 5),
        Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}