import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/dislikes_model.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/ui/widgets/food_display.dart';
import 'package:hot_foods/utils/color_utils.dart';

class DislikesView extends StatelessWidget {
  const DislikesView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<DislikesModel>(
      onModelReady: (model) => model.init(),
      builder: (context, child, model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
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
                      'Super dislikes',
                      style: TextStyle(
                          color: FoodColors.red,
                          fontSize: 22,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
            ],
          ),
          // Padding(
          //   padding: EdgeInsets.only(left: 40, top: 10, bottom: 10),
          //   child: 
          // ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: GridView.count(
                childAspectRatio: 2 / 3,
                crossAxisCount: 2,
                children: model.dislikes
                    .map((foodItem) => Padding(
                        padding: EdgeInsets.all(10),
                        child: FoodDisplay(
                          user: model.authService.self!,
                          foodItem: foodItem,
                          fontSizeMultiplier: 0.7,
                        )))
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
