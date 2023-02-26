import 'package:flutter/cupertino.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/ui/view/login_view.dart';
import 'package:hot_foods/ui/view/register_view.dart';
import 'package:hot_foods/utils/nav_utils.dart';

class HomeModel extends BaseModel {
  void login(BuildContext context) {
    navTo(context, (_) => LoginView());
  }
  
  void register(BuildContext context) {
    navTo(context, (_) => RegisterView());
  }
}
