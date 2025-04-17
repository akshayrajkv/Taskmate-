import 'package:task_mate2/features/auth/model/usermodel.dart';
import 'package:task_mate2/features/auth/services/auth_services.dart';

class AuthRepository {
  final ApiService _apiService = ApiService();

  Future<Map<String, dynamic>> register(User user) async {
    return await _apiService.registerUser(user);
  }

  Future<Map<String, dynamic>> login(User user) async {
    return await _apiService.loginUser(user);
    
  }

}
