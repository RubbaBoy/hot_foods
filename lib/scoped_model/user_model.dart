import 'package:hot_foods/scoped_model/base_model.dart';

class UserModel extends BaseModel {
  
  String getName() {
    return '${authService.self?.firstName ?? ''} ${authService.self?.lastName ?? ''}';
  }
  
  String getEmail() {
    return authService.self?.email ?? '';
  }
  
}
