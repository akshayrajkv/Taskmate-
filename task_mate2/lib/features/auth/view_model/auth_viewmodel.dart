import 'package:flutter/material.dart';
import 'package:task_mate2/features/auth/model/usermodel.dart';
import '../repository/auth_repository.dart';

class AuthViewModel extends ChangeNotifier {
  final AuthRepository _authRepository = AuthRepository();
  bool _isLoading = false;
  String? _authToken;

  bool get isLoading => _isLoading;
  String? get authToken => _authToken;

  Future<String?> register(  String username, String password,String email) async {
    _isLoading = true;
    notifyListeners();

    User user = User(email: email, password: password,name: username);
    final response = await _authRepository.register(user);

    _isLoading = false;
    notifyListeners();

    return response["message"];
  }

  Future<String?> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    User user = User(email: email, password: password);
    final response = await _authRepository.login(user);

    _isLoading = false;
    notifyListeners();

    if (response["success"]) {
      _authToken = response["token"];
      return null;
    } else {
      return response["message"];
    }
  }
}
