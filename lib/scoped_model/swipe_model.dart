import 'package:hot_foods/scoped_model/base_model.dart';

class SwipeModel extends BaseModel {
  
  bool favoriteMode = true;
  
  void switchToOrderMode() {
    favoriteMode = false;
    notifyListeners();
  }
  
  void switchToFavoriteMode() {
    favoriteMode = true;
    notifyListeners();
  }
  
}