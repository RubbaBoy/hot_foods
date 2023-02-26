import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';

class NormalModel extends BaseModel {
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
    return requestService.swipeNext();
  }

  void superDislikeCallback(FoodItem foodItem) {
    requestService.swipeSubmit(foodItem.id, Swipe.superdislike);
  }
  
  void superLikeCallback(FoodItem foodItem) {
    requestService.swipeSubmit(foodItem.id, Swipe.superlike);
  }
  
  void likeCallback(FoodItem foodItem) {
    requestService.swipeSubmit(foodItem.id, Swipe.like);
  }
  
  void dislikeCallback(FoodItem foodItem) {
    print('Dislike callback for ${foodItem.id}');
    requestService.swipeSubmit(foodItem.id, Swipe.dislike);
  }
  
}
