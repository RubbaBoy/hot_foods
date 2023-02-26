import 'package:flutter/cupertino.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';

class IntolerancesModel extends BaseModel {
  final addController = TextEditingController();
  
  List<String> get intolerances => authService.self?.intolerances ?? [];
  
  void addIntolerance() {
    var adding = addController.value.text;
    var self = authService.self;
    
    if (self != null) {
      print(adding);
      addController.clear();
      intolerances.add(adding);
      requestService.update(UpdateUser(self.allergens, intolerances, self.vegan, self.vegetarian));
      notifyListeners();
    }
  }
  
  void removeIntolerance(String allergen) {
    var self = authService.self;

    if (self != null) {
      intolerances.remove(allergen);
      requestService.update(UpdateUser(self.allergens, intolerances, self.vegan, self.vegetarian));
      notifyListeners();
    }
  }
  
}
