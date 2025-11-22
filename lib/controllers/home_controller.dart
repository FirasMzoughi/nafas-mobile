import 'package:flutter/material.dart';
import 'package:malath/services/home_service.dart';

class HomeController extends ChangeNotifier {
  final HomeService _homeService = HomeService();

  List<Map<String, dynamic>> _voiceRooms = [];
  List<Map<String, dynamic>> _posts = [];
  bool _isLoadingRooms = true;
  bool _isLoadingPosts = true;

  List<Map<String, dynamic>> get voiceRooms => _voiceRooms;
  List<Map<String, dynamic>> get posts => _posts;
  bool get isLoadingRooms => _isLoadingRooms;
  bool get isLoadingPosts => _isLoadingPosts;

  HomeController() {
    fetchData();
  }

  Future<void> fetchData() async {
    _isLoadingRooms = true;
    _isLoadingPosts = true;
    notifyListeners();

    try {
      final results = await Future.wait([
        _homeService.getVoiceRooms(),
        _homeService.getPosts(),
      ]);

      _voiceRooms = results[0];
      _posts = results[1];
    } catch (e) {
      debugPrint('Error fetching home data: $e');
    } finally {
      _isLoadingRooms = false;
      _isLoadingPosts = false;
      notifyListeners();
    }
  }

  void toggleLike(int index) {
    if (index >= 0 && index < _posts.length) {
      _posts[index]['isLiked'] = !_posts[index]['isLiked'];
      if (_posts[index]['isLiked']) {
        _posts[index]['likes']++;
      } else {
        _posts[index]['likes']--;
      }
      notifyListeners();
    }
  }
}
