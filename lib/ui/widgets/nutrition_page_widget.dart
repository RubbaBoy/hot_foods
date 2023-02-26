import 'package:flutter/material.dart';
import 'package:hot_foods/services/request_service.dart';
import 'package:hot_foods/utils/color_utils.dart';
import 'package:hot_foods/vendor/nutrient_facts_flutter/nutrientfacts.dart';

class NutritionPageWidget extends StatelessWidget {
  final Function() scrollUp;
  final FoodItem foodItem;

  NutritionPageWidget(
      {super.key, required this.scrollUp, required this.foodItem}) {
    print(foodItem);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: RotatedBox(
                    quarterTurns: 1,
                    child: IconButton(
                      onPressed: () => scrollUp(),
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
          ),
          RichText(
            text: TextSpan(
              text: foodItem.name,
              style: TextStyle(
                  color: FoodColors.red,
                  fontSize: 20,
                  fontWeight: FontWeight.w700),
              children: <TextSpan>[
                TextSpan(
                    text: ' Nutrition Info',
                    style: TextStyle(fontWeight: FontWeight.w400)),
              ],
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: NutritionFacts(
              nutrientData: createData(),
              calories: foodItem.calories,
              servings: foodItem.servingsPerContainer,
              servingSize: foodItem.servingSize,
            ),
          ),
          SizedBox(height: 10),
          Container(
            height: 200,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 15),
                  RichText(
                    text: TextSpan(
                      text: 'Contains: ',
                      style: TextStyle(color: FoodColors.red, fontSize: 18),
                      children: <TextSpan>[
                        TextSpan(
                            text: foodItem.allergens.join(', '),
                            style: TextStyle(color: Colors.black)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: RichText(
                      text: TextSpan(
                        text: 'Ingredients: ',
                        style: TextStyle(color: FoodColors.red, fontSize: 18),
                        children: <TextSpan>[
                          TextSpan(
                              text:
                                  foodItem.ingredients.join(', '),
                              style: TextStyle(color: Colors.black)),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  String getUnit(String str) => str.contains('mg') ? 'mg' : 'g';

  int getNumber(String str) =>
      int.tryParse(str.substring(0, str.length - getUnit(str).length)) ?? 0;

  dynamic createData() => {
        'FAT': {
          'amount': getNumber(foodItem.totalFat),
          'unit': getUnit(foodItem.totalFat)
        },
        'SATFAT': {
          'amount': getNumber(foodItem.saturatedFat),
          'unit': getUnit(foodItem.saturatedFat)
        },
        'TRANSFAT': {
          'amount': getNumber(foodItem.transFat),
          'unit': getUnit(foodItem.transFat)
        },
        'CHOLE': {
          'amount': getNumber(foodItem.cholesterol),
          'unit': getUnit(foodItem.cholesterol)
        },
        'NA': {
          'amount': getNumber(foodItem.sodium),
          'unit': getUnit(foodItem.sodium)
        },
        'CHOCDF': {
          'amount': getNumber(foodItem.totalCarbohydrate),
          'unit': getUnit(foodItem.totalCarbohydrate)
        },
        'FIBTG': {
          'amount': getNumber(foodItem.dietaryFiber),
          'unit': getUnit(foodItem.dietaryFiber)
        },
        'SUGAR': {
          'amount': getNumber(foodItem.totalSugars),
          'unit': getUnit(foodItem.totalSugars)
        },
        'PROCNT': {
          'amount': getNumber(foodItem.protein),
          'unit': getUnit(foodItem.protein)
        },
      };
}
