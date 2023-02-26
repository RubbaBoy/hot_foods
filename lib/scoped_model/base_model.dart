import 'package:hot_foods/service_locator.dart';
import 'package:hot_foods/services/auth_service.dart';
import 'package:hot_foods/services/food_service.dart';
import 'package:hot_foods/services/request_service.dart';
import 'package:scoped_model/scoped_model.dart';

class BaseModel extends Model {
  final authService = locator<AuthService>();
  final requestService = locator<RequestService>();
  final foodService = locator<FoodService>();
}
