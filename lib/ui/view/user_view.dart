import 'package:flutter/material.dart';
import 'package:hot_foods/scoped_model/user_model.dart';
import 'package:hot_foods/ui/view/allergens_view.dart';
import 'package:hot_foods/ui/view/base_view.dart';
import 'package:hot_foods/ui/view/dislikes_view.dart';
import 'package:hot_foods/ui/view/intolerances_view.dart';
import 'package:hot_foods/utils/color_utils.dart';
import 'package:hot_foods/utils/nav_utils.dart';

class UserView extends StatelessWidget {
  const UserView({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseView<UserModel>(
      builder: (context, child, model) => Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 25, left: 10),
                      child: IconButton(
                        onPressed: () => Navigator.of(context).pop(),
                        iconSize: 42,
                        icon: Icon(
                          Icons.chevron_left,
                          color: FoodColors.red,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  model.getName(),
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 22,
                      color: FoodColors.red),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 30),
                  child: Text(
                    model.getEmail(),
                    style: TextStyle(
                        fontWeight: FontWeight.w300,
                        decoration: TextDecoration.underline,
                        fontSize: 16),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Column(
                      children: [
                        // createButton(
                        //     name: 'Favorites',
                        //     icon: Icon(
                        //       Icons.favorite,
                        //       color: Colors.black,
                        //     ),
                        //     onClick: () => print('Favorites')),
                        // SizedBox(height: 10),
                        createButton(
                            name: 'Dislikes',
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onClick: () => navTo(context, (_) => DislikesView())),
                        SizedBox(height: 30),
                        createButton(
                            name: 'Allergens',
                            icon: Icon(
                              Icons.not_interested,
                              color: Colors.red,
                            ),
                            onClick: () => navTo(context, (_) => AllergensView())),
                        SizedBox(height: 10),
                        createButton(
                            name: 'Intolerances',
                            icon: Icon(
                              Icons.notifications_active,
                              color: Colors.yellow,
                            ),
                            onClick: () => navTo(context, (_) => IntolerancesView())),
                      ],
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget createButton(
          {required String name,
          required Widget icon,
          required Function() onClick}) =>
      ElevatedButton(
        onPressed: onClick,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              icon,
              SizedBox(width: 12),
              Text(
                name,
                style: TextStyle(color: Colors.black, fontSize: 16),
              ),
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
