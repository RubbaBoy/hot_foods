import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/normal_model.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/ui/widgets/nutrition_page_widget.dart';
import 'package:hot_foods/ui/widgets/swiping_items_widget.dart';
import 'package:hot_foods/utils/color_utils.dart';
import 'package:hot_foods/vendor/nutrient_facts_flutter/nutrientfacts.dart';

class NormalWidget extends StatefulWidget {
  const NormalWidget({Key? key}) : super(key: key);

  @override
  State<NormalWidget> createState() => _NormalWidgetState();
}

class _NormalWidgetState extends State<NormalWidget> {
  @override
  Widget build(BuildContext context) {
    return BaseView<NormalModel>(
      onModelReady: (model) => model.init(),
      onModelEnd: (model) => model.deinit(),
      builder: (context, child, model) => PageView(
        scrollDirection: Axis.vertical,
        controller: model.pageController,
        children: [
          buildTop(context, model),
          if (model.foodService.currentFoodItem != null)
            NutritionPageWidget(
              scrollUp: model.scrollUp,
              foodItem: model.foodService.currentFoodItem!,
            )
        ],
      ),
    );
  }

  Widget buildTop(BuildContext context, NormalModel model) => Column(
        children: [
          Expanded(
            child: SwipingItemsWidget(
              getNextFood: model.getNextFood,
              superDislike: model.superDislikeCallback,
              superLike: model.superLikeCallback,
              like: model.likeCallback,
              dislike: model.dislikeCallback,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RotatedBox(
                    quarterTurns: 3,
                    child: IconButton(
                      onPressed: () => model.scrollDown(),
                      iconSize: 42,
                      icon: Icon(
                        Icons.chevron_left,
                        color: FoodColors.red,
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      );
}
