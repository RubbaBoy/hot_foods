import 'package:flutter/material.dart';
import 'package:hot_foods/services/request_service.dart';

class FoodDisplay extends StatelessWidget {
  final User user;
  final FoodItem foodItem;
  final double fontSizeMultiplier;
  final List<String> ingredients;

  FoodDisplay(
      {super.key,
      required this.user,
      required this.foodItem,
      this.fontSizeMultiplier = 1})
      : ingredients = foodItem.ingredients.map((e) => e.toLowerCase()).toList() {
    print(foodItem.image);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
          image: DecorationImage(
            image: Image.asset(
              foodItem.image,
              gaplessPlayback: true,
            ).image,
            fit: BoxFit.fitHeight,
            alignment: Alignment.center,
          ),
        ),
      ),
      Positioned(
        bottom: 67 * fontSizeMultiplier,
        left: 13,
        child: Text(
          foodItem.name, // Jollof Rice Meal
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w700,
            fontSize: fontSizeMultiplier * 22,
          ),
        ),
      ),
      Positioned(
        bottom: 35 * fontSizeMultiplier,
        left: 10,
        child: Text(
          foodItem.location.displayName, // Brick City Cafe
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontSize: fontSizeMultiplier * 20,
          ),
        ),
      ),
      if (hasIntolerance())
        Positioned(
          bottom: 25 * fontSizeMultiplier,
          right: 25 * fontSizeMultiplier,
          child: Image.asset(
            'images/warning.png',
            height: 40,
            width: 40,
          ),
        ),
    ]);
  }

  bool hasIntolerance() => user.intolerances
      .map((e) => e.toLowerCase())
      .any((element) => ingredients.contains(element));
}
