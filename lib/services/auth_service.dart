import 'package:flutter/material.dart';

class AuthService {
  // Mock login
  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simulate network delay
    if (email.isNotEmpty && password.isNotEmpty) {
      return true;
    }
    return false;
  }

  // Mock logout
  Future<void> logout() async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
