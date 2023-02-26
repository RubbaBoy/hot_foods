import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/register_model.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/utils/color_utils.dart';

class RegisterView extends StatelessWidget {

  static final MaterialColor redColor = MaterialColor(FoodColors.red.value, <int, Color>{
    50: FoodColors.red.withOpacity(0.1),
    100: FoodColors.red.withOpacity(0.2),
    200: FoodColors.red.withOpacity(0.3),
    300: FoodColors.red.withOpacity(0.4),
    400: FoodColors.red.withOpacity(0.5),
    500: FoodColors.red.withOpacity(0.6),
    600: FoodColors.red.withOpacity(0.7),
    700: FoodColors.red.withOpacity(0.8),
    800: FoodColors.red.withOpacity(0.9),
    900: FoodColors.red.withOpacity(1),
  },);

  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterModel>(
      builder: (context, child, model) => Container(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: model.firstNameController,
                decoration: InputDecoration(
                  hintText: 'First name',
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  labelStyle: new TextStyle(color: Colors.green),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                controller: model.lastNameController,
                decoration: InputDecoration(
                  hintText: 'Last name',
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  labelStyle: new TextStyle(color: Colors.green),
                ),
              ),
              SizedBox(height: 20,),
              TextField(
                  controller: model.emailController,
                  decoration: InputDecoration(
                    hintText: 'Email',
                    contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(color: FoodColors.red, width: 2),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(color: FoodColors.red, width: 2),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(25)),
                      // width: 0.0 produces a thin "hairline" border
                      borderSide: BorderSide(color: FoodColors.red, width: 2),
                    ),
                    labelStyle: new TextStyle(color: Colors.green),
                  ),
                ),
              SizedBox(height: 20,),
              TextField(
                controller: model.passwordController,
                decoration: InputDecoration(
                  hintText: 'Password',
                  contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    // width: 0.0 produces a thin "hairline" border
                    borderSide: BorderSide(color: FoodColors.red, width: 2),
                  ),
                  labelStyle: new TextStyle(color: Colors.green),
                ),
              ),
              SizedBox(height: 20),
              Row(children: [
                Theme(
                  data: ThemeData(
                  primarySwatch: redColor,
                    unselectedWidgetColor: FoodColors.red, // Your color
              ),
                  child: Checkbox(
                      value: model.isVegan,
                      onChanged: (value) {
                        model.isVegan = value!;
                        model.notifyListeners();
                      }),
                ),
                Text('Vegan')
              ]),
              Row(
                children: [
                  Theme(
                    data: ThemeData(
                      primarySwatch: redColor,
                      unselectedWidgetColor: FoodColors.red, // Your color
                    ),
                    child: Checkbox(
                      value: model.isVegetarian,
                      onChanged: (value) {
                        model.isVegetarian = value!;
                        model.notifyListeners();
                      }),
                  ),
                  Text('Vegetarian')
                ],
              ),
              SizedBox(height: 50),
              ElevatedButton(
                onPressed: () => model.submit(context),
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    'Register',
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
                style: ButtonStyle(
                    backgroundColor:
                    MaterialStatePropertyAll<Color>(FoodColors.red),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0)))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
