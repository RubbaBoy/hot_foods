import 'package:hot_foods/services/request_service.dart';

class AuthService {
  String? _authToken = '';
  User? self;
  
  String get authToken {
    if (_authToken == null) {
      throw 'Attempted to get auth token while logged out';
    }
    
    return _authToken!;
  }
  
  set authToken(String token) => _authToken = token;
  
  bool get isLoggedIn => self != null;
}
