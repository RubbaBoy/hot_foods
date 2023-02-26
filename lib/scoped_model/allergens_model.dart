import 'package:flutter/cupertino.dart';
import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';

class AllergensModel extends BaseModel {
  final addController = TextEditingController();
  
  List<String> get allergens => authService.self?.allergens ?? [];
  
  void addAllergen() {
    var adding = addController.value.text;
    var self = authService.self;
    
    if (self != null) {
      print(adding);
      addController.clear();
      allergens.add(adding);
      requestService.update(UpdateUser(allergens, self.intolerances, self.vegan, self.vegetarian));
      notifyListeners();
    }
  }
  
  void removeAllergen(String allergen) {
    var self = authService.self;

    if (self != null) {
      allergens.remove(allergen);
      requestService.update(UpdateUser(allergens, self.intolerances, self.vegan, self.vegetarian));
      notifyListeners();
    }
  }
  
}
