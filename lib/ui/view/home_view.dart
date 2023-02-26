import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/home_model.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/utils/color_utils.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<HomeModel>(
      builder: (context, child, model) => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 70, left: 40, right: 40),
                  child: Image.asset('images/logo.png'),
                ),
                Spacer(),
                ElevatedButton(
                  onPressed: () => model.login(context),
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
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => model.register(context),
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
                SizedBox(height: 30,),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
