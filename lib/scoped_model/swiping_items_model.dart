import 'package:flutter/cupertino.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';
import 'package:hot_foods/utils/toast_utility.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipingItemsModel extends BaseModel {
  MatchEngine? matchEngine;
  final swipeItems = <SwipeItem>[];
  late Future<FoodItem> Function() getNextFood;
  late Function(FoodItem foodItem) superDislikeCallback;
  late Function(FoodItem foodItem) superLikeCallback;
  late Function(FoodItem foodItem) likeCallback;
  late Function(FoodItem foodItem) dislikeCallback;

  Future<void> init(BuildContext context, Future<FoodItem> Function() getNextFood, Function(FoodItem foodItem) superDislikeCallback, Function(FoodItem foodItem) superLikeCallback, Function(FoodItem foodItem) likeCallback, Function(FoodItem foodItem) dislikeCallback) async {
    this.getNextFood = getNextFood;
    this.superDislikeCallback = superDislikeCallback;
    this.superLikeCallback = superLikeCallback;
    this.likeCallback = likeCallback;
    this.dislikeCallback = dislikeCallback;
    
    matchEngine = MatchEngine(swipeItems: swipeItems);
    matchEngine?.addListener(() {
      if (matchEngine?.currentItem?.content != null) {
        print('Setting food!');
        foodService.currentFoodItem = matchEngine!.currentItem!.content as FoodItem;
        getNext(context);
        notifyListeners();
      }
    });
    
    var initialFood = await getNext(context);
    foodService.currentFoodItem = initialFood;
    notifyListeners();
    
    await getNext(context);
    await getNext(context);
  }
  
  void resetFood() {
    foodService.currentFoodItem = null;
    notifyListeners();
  }

  Future<FoodItem> getNext(BuildContext context) async {
    var next = await getNextFood(); // await requestService.swipeNext()
    swipeItems.add(SwipeItem(
        content: next,
        likeAction: () {
          likeCallback(next);
        },
        nopeAction: () {
          dislikeCallback(next);
        },
        superlikeAction: () {
          superLikeCallback(next);
        }));
    
    notifyListeners();
    return next;
  }
}
