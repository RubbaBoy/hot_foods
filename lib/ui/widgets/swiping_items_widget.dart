import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/swiping_items_model.dart';
import 'package:hot_foods/services/request_service.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/ui/widgets/food_display.dart';
import 'package:swipe_cards/swipe_cards.dart';

class SwipingItemsWidget extends StatefulWidget {
  final bool showButtons;
  final bool enableSuperlike;
  final Future<FoodItem> Function() getNextFood;
  final Function(FoodItem foodItem) superDislike;
  final Function(FoodItem foodItem) superLike;
  final Function(FoodItem foodItem) like;
  final Function(FoodItem foodItem) dislike;

  const SwipingItemsWidget(
      {Key? key, 
        required this.getNextFood,
      required this.superDislike,
      required this.superLike,
      required this.like,
      required this.dislike,
        this.enableSuperlike = true,
      this.showButtons = true})
      : super(key: key);

  @override
  State<SwipingItemsWidget> createState() => SwipingItemsWidgetState();
}

class SwipingItemsWidgetState extends State<SwipingItemsWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SwipingItemsModel>(
      onModelReady: (model) => model.init(context, widget.getNextFood, widget.superDislike, widget.superLike, widget.like, widget.dislike),
      builder: (context, child, model) => Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(top: 32, right: 32, left: 32),
              child: model.matchEngine == null
                  ? Text('Loading...')
                  : Container(
                      height: 550,
                      child: SwipeCards(
                        upSwipeAllowed: widget.enableSuperlike,
                        matchEngine: model.matchEngine!,
                        onStackFinished: () => print('finished'),
                        itemBuilder: (context, index) {
                          var item =
                              model.swipeItems[index].content as FoodItem;
                          return FoodDisplay(
                            user: model.authService.self!,
                            foodItem: item,
                          );
                        },
                      ),
                    ),
            ),
          ),
          if (widget.showButtons)
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      var currentItem = model.matchEngine?.currentItem!;
                      if (currentItem != null) {
                        currentItem.nope();
                        widget.superDislike(currentItem.content);
                      }
                    },
                    iconSize: 55,
                    icon: Image.asset(
                      'images/super-dislike.png',
                      width: 55,
                      height: 55,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      var currentItem = model.matchEngine?.currentItem!;
                      if (currentItem != null) {
                        currentItem.superLike();
                        widget.superLike(currentItem.content);
                      }
                    },
                    iconSize: 55,
                    icon: Image.asset(
                      'images/super-like.png',
                      width: 55,
                      height: 55,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
