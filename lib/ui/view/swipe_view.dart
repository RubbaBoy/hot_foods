import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/swipe_model.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/ui/view/cart_view.dart';
import 'package:hot_foods/ui/view/user_view.dart';
import 'package:hot_foods/ui/widgets/normal_widget.dart';
import 'package:hot_foods/ui/widgets/order_widget.dart';
import 'package:hot_foods/utils/color_utils.dart';
import 'package:hot_foods/utils/nav_utils.dart';

class SwipeView extends StatefulWidget {
  const SwipeView({Key? key}) : super(key: key);

  @override
  State<SwipeView> createState() => _SwipeViewState();
}

class _SwipeViewState extends State<SwipeView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<SwipeModel>(
      builder: (context, child, model) => Column(
        children: [
          Row(
            mainAxisAlignment: model.favoriteMode ? MainAxisAlignment.end : MainAxisAlignment.spaceBetween,
            children: [
              if (!model.favoriteMode)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                  child: IconButton(
                      onPressed: () => navTo(context, (_) => CartView()),
                      icon: Icon(Icons.shopping_cart)),
                ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, right: 8.0),
                child: IconButton(
                    onPressed: () => navTo(context, (_) => UserView()),
                    icon: Icon(Icons.account_circle_outlined)),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: model.favoriteMode
                            ? FoodColors.red
                            : FoodColors.gray,
                        width: 3),
                  ),
                ),
                child: TextButton(
                  onPressed: () => model.switchToFavoriteMode(),
                  child: Text(
                    'Favorite Swipes',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: model.favoriteMode
                            ? FoodColors.red
                            : FoodColors.gray),
                  ),
                ),
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                        color: !model.favoriteMode
                            ? FoodColors.red
                            : FoodColors.gray,
                        width: 3),
                  ),
                ),
                child: TextButton(
                  onPressed: () => model.switchToOrderMode(),
                  child: Text(
                    'Order Mode',
                    style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: !model.favoriteMode
                            ? FoodColors.red
                            : FoodColors.gray),
                  ),
                ),
              ),
            ],
          ),
          Expanded(
              // child: NormalWidget())
              child: model.favoriteMode ? NormalWidget() : OrderWidget())
        ],
      ),
    );
  }
}
