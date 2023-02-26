import 'package:hot_foods/scoped_model/base_model.dart';
import 'package:hot_foods/services/request_service.dart';
import 'package:collection/collection.dart';

class CartModel extends BaseModel {

  List<FoodItem> cart = [];

  Map<Location, List<FoodItem>> get groupedCart {
    if (cart.isEmpty) {
      return {};
    }

    var b = groupBy(cart, (item) => item.location);
    print(b);
    // b[Location.BrickCity] = b.entries.first.value;
    // b[Location.Salsaritas] = b.entries.first.value;
    // b[Location.Sols] = b.entries.first.value;
    return b;
  }

  void init() {
    print('initttt');
    requestService.startCart().then((_) {
      requestService.listCart().then((items) {
        cart = items;
        notifyListeners();
      });
    });
  }

}
