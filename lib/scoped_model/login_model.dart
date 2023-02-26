import 'package:flutter/cupertino.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/auth_service.dart';
import 'package:hot_foods/ui/view/swipe_view.dart';
import 'package:hot_foods/utils/nav_utils.dart';
import 'package:hot_foods/utils/toast_utility.dart';

class LoginModel extends BaseModel {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  Future<void> submit(BuildContext context) async {
    requestService.login(emailController.value.text, passwordController.value.text).then((success) {
      notifyListeners();
      if (!success) {
        sendToast(context, 'Login failed!');
        return;
      }

      navTo(context, (_) => SwipeView());
    });
  }
}
