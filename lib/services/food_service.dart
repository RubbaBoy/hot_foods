import 'package:flutter/widgets.dart';
import 'package:hot_foods/services/request_service.dart';

class FoodService {
  final ValueNotifier<FoodItem?> _currentFoodItem = ValueNotifier(null);
  
  set currentFoodItem(FoodItem? foodItem) {
    print('Setting $foodItem');
    _currentFoodItem.value = foodItem;
  }
  
  FoodItem? get currentFoodItem => _currentFoodItem.value;
  
  ValueNotifier<FoodItem?> get currentFoodItemNotifier => _currentFoodItem;
}
