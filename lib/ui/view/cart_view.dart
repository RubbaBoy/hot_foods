import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/cart_model.dart';
import 'package:hot_foods/scoped_model/dislikes_model.dart';
import 'package:hot_foods/services/request_service.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/ui/widgets/food_display.dart';
import 'package:hot_foods/utils/color_utils.dart';

class CartView extends StatelessWidget {
  const CartView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<CartModel>(
      onModelReady: (model) => model.init(),
      builder: (context, child, model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25, left: 10),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  iconSize: 42,
                  icon: Icon(
                    Icons.chevron_left,
                    color: FoodColors.red,
                  ),
                ),
                SizedBox(width: 5),
                Text(
                  'Current Cart Options',
                  style: TextStyle(
                      // color: FoodColors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 20),
              // child: SingleChildScrollView(
              // color: Colors.red,
              child: ListView(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                children: [
                  ...model.groupedCart.entries
                      .map((entry) => displayCart(model.authService.self!, entry.key, entry.value))
                      .expand((element) => element),
                ],
              ),
            ),
          ),
          // ),
        ],
      ),
    );
  }

  List<Widget> displayCart(User user, Location location, List<FoodItem> foodItems) => [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            Text(
              location.displayName,
              textAlign: TextAlign.left,
              style: TextStyle(
                  color: FoodColors.red,
                  fontSize: 22,
                  fontWeight: FontWeight.w700),
            ),
          ],
        ),
        GridView.count(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 2 / 3,
          crossAxisCount: 2,
          children: foodItems
              .map((foodItem) => Padding(
                  padding: EdgeInsets.all(10),
                  child: FoodDisplay(
                    user: user,
                    foodItem: foodItem,
                    fontSizeMultiplier: 0.7,
                  )))
              .toList(),
        ),
        SizedBox(height: 20),
      ];
}
