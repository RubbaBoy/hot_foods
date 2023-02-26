import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';

class DislikesModel extends BaseModel {
  
  List<FoodItem> dislikes = [];
  
  void init() {
    requestService.listDislikes().then((value) {
      dislikes = [...value, ...value, ...value, ...value, ...value];
      notifyListeners();
    });
  }
  
}