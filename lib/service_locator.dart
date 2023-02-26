import 'package:get_it/get_it.dart';
import 'package:hot_foods/scoped_model/allergens_model.dart';
import 'package:hot_foods/scoped_model/dislikes_model.dart';
import 'package:hot_foods/scoped_model/home_model.dart';
import 'package:hot_foods/scoped_model/login_model.dart';
import 'package:hot_foods/scoped_model/order_model.dart';
import 'package:hot_foods/scoped_model/register_model.dart';
import 'package:hot_foods/scoped_model/swipe_model.dart';
import 'package:hot_foods/scoped_model/swiping_items_model.dart';
import 'package:hot_foods/scoped_model/user_model.dart';
import 'package:hot_foods/services/auth_service.dart';
import 'package:hot_foods/services/food_service.dart';
import 'package:hot_foods/services/request_service.dart';

import 'scoped_model/cart_model.dart';
import 'scoped_model/intolerances_model.dart';
import 'scoped_model/normal_model.dart';

final locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => AuthService());
  locator.registerLazySingleton(() => RequestService());
  locator.registerLazySingleton(() => FoodService());
  
  locator.registerFactory(() => HomeModel());
  locator.registerFactory(() => LoginModel());
  locator.registerFactory(() => RegisterModel());
  locator.registerFactory(() => SwipeModel());
  locator.registerFactory(() => SwipingItemsModel());
  locator.registerFactory(() => NormalModel());
  locator.registerFactory(() => OrderModel());
  locator.registerFactory(() => UserModel());
  locator.registerFactory(() => DislikesModel());
  locator.registerFactory(() => AllergensModel());
  locator.registerFactory(() => IntolerancesModel());
  locator.registerFactory(() => CartModel());
}
