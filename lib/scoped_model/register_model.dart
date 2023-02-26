import 'package:flutter/cupertino.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';
import 'package:hot_foods/ui/view/swipe_view.dart';
import 'package:hot_foods/utils/nav_utils.dart';

class RegisterModel extends BaseModel {
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final allergensController = TextEditingController();
  final intolerancesController = TextEditingController();

  bool isVegetarian = false;
  bool isVegan = false;

  void submit(BuildContext context) {
    print('Heree');
    requestService.register(RegisterUser(
        firstNameController.value.text,
        lastNameController.value.text,
        emailController.value.text,
        passwordController.value.text,
        [],
        [],
        isVegan,
        isVegetarian)).then((_) => navTo(context, (_) => SwipeView()));
  }
}
