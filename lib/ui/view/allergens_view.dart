import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/allergens_model.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/utils/color_utils.dart';

class AllergensView extends StatelessWidget {
  const AllergensView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<AllergensModel>(
      // onModelReady: (model) => model.init(),
      builder: (context, child, model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 25, left: 10, bottom: 15),
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
                  'Allergens',
                  style: TextStyle(
                      color: FoodColors.red,
                      fontSize: 22,
                      fontWeight: FontWeight.w700),
                ),
              ],
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                children: [
                  TextField(
                    controller: model.addController,
                    onSubmitted: (_) => model.addAllergen(),
                    decoration: InputDecoration(
                        hintText: 'Add an allergen',
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              const BorderSide(color: FoodColors.red, width: 2),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              const BorderSide(color: FoodColors.red, width: 2),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide:
                              const BorderSide(color: FoodColors.red, width: 2),
                        ),
                        labelStyle: new TextStyle(color: Colors.green),
                        suffixIcon: Padding(
                          padding: EdgeInsets.only(right: 12),
                          child: IconButton(
                            icon: Icon(
                              Icons.check,
                              color: Colors.green,
                            ),
                            onPressed: () => model.addAllergen(),
                          ),
                        )),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      children: model.allergens
                          .map((allergen) => Padding(
                              padding: EdgeInsets.symmetric(vertical: 3),
                              child: createAllergen(
                                  name: allergen,
                                  icon: InkWell(
                                    child: Icon(Icons.close),
                                    onTap: () => model.removeAllergen(allergen),
                                  ))))
                          .toList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget createAllergen({required String name, required Widget icon}) =>
      ElevatedButton(
        onPressed: null,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Text(
                name,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
              Spacer(),
              icon,
            ],
          ),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStatePropertyAll<Color>(FoodColors.buttonGray),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0)))),
      );
}
