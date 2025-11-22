import 'package:flutter/material.dart';

class ProfileController extends ChangeNotifier {
  bool _isEditing = false;
  String _name = 'Sarah Johnson';
  String _bio = 'On a journey to better mental health. Grateful for this community. 💚';
  String _username = '@sarah_j';
  String _memberSince = '2024';

  // Stats
  int _hearts = 127;
  int _sessions = 12;
  int _streaks = 5;

  bool get isEditing => _isEditing;
  String get name => _name;
  String get bio => _bio;
  String get username => _username;
  String get memberSince => _memberSince;
  int get hearts => _hearts;
  int get sessions => _sessions;
  int get streaks => _streaks;

  void toggleEdit() {
    _isEditing = !_isEditing;
    notifyListeners();
  }

  void updateName(String newName) {
    _name = newName;
    notifyListeners();
  }

  void updateBio(String newBio) {
    _bio = newBio;
    notifyListeners();
  }

  void saveProfile() {
    _isEditing = false;
    notifyListeners();
  }
}
