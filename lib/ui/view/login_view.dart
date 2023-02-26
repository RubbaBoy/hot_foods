import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hot_foods/scoped_model/login_model.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/utils/color_utils.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginModel>(
      builder: (context, child, model) => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75),
                  child: TextField(
                    controller: model.emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: FoodColors.red, width: 2),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: FoodColors.red, width: 2),
                        ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: FoodColors.red, width: 2),
                        ),
                        labelStyle: new TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 75),
                  child: TextField(
                    controller: model.passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                        contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: FoodColors.red, width: 2),
                        ),
                        border: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: FoodColors.red, width: 2),
                        ),
                      focusedBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          // width: 0.0 produces a thin "hairline" border
                          borderSide: const BorderSide(color: FoodColors.red, width: 2),
                        ),
                        labelStyle: new TextStyle(color: Colors.green),
                    ),
                  ),
                ),
                SizedBox(height: 50,),
                ElevatedButton(
                  onPressed: () => model.submit(context),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      'Sign in',
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
        ],
      ),
    );
  }
}
