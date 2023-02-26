import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';

class OrderModel extends BaseModel {

  final pageController = PageController();
  Function()? listenerStuff;

  void init() {
    listenerStuff = listener;
    foodService.currentFoodItemNotifier.addListener(listenerStuff!);
  }

  void deinit() {
    foodService.currentFoodItem = null;
    foodService.currentFoodItemNotifier.removeListener(listenerStuff!);
  }

  void listener() {
    notifyListeners();
  }

  void scrollDown() {
    pageController.animateToPage(1,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }

  void scrollUp() {
    pageController.animateToPage(0,
        duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
  }
  
  Future<FoodItem> getNextFood() {
    return requestService.cartNext();
  }

  void superDislikeCallback(FoodItem foodItem) {}

  void superLikeCallback(FoodItem foodItem) {}

  void likeCallback(FoodItem foodItem) {
    requestService.cartSwipe(foodItem.id, CartSwipe.add);
  }

  void dislikeCallback(FoodItem foodItem) {
    requestService.cartSwipe(foodItem.id, CartSwipe.ignore);
  }
}
