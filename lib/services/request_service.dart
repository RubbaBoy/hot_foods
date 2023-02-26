import 'dart:convert';

import 'package:hot_foods/service_locator.dart';
import 'package:hot_foods/services/auth_service.dart';
import 'package:http/http.dart' as http;

class RequestService {
  static const baseUri = 'http://172.30.0.3:8085';
  // static const baseUri = 'https://stoplight.io/mocks/adamyarris/bruh/143076860';
  final authService = locator<AuthService>();

  Map<String, String> get _authedHeaders => {
        'Content-Type': 'application/json',
        'accessToken': authService.authToken
      };

  Future<bool> login(String email, String password) {
    print('Login! $email $password');
    return http
        .post(Uri.parse('$baseUri/auth/login'),
            headers: {'Content-Type': 'application/json'},
            body: json.encode({
              'email': email,
              'password': password,
            }))
        .then((response) {
      print(response.statusCode);
      if (response.statusCode == 200) {
        print(response.headers);
        authService.authToken = response.headers['access-token'] ?? ''; // TODO
        print(authService.authToken);
        // authService.authToken = 'BALLS';
        print(jsonDecode(response.body));
        authService.self = User.fromJson(jsonDecode(response.body));
        return true;
      }

      return false;
    });
  }

  Future<void> register(RegisterUser registerUser) {
    return http.post(Uri.parse('$baseUri/auth/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(registerUser.toJson())).then((response) {
      // print(response.statusCode);
    }).then((value) async {
      await login(registerUser.email, registerUser.password);
    });
  }

  Future<void> update(UpdateUser updateUser) {
    return http.post(Uri.parse('$baseUri/user/update'),
        headers: _authedHeaders, body: json.encode(updateUser.toJson()));
  }

  Future<FoodItem> swipeNext() {
    return http
        .get(Uri.parse('$baseUri/swipe/next'), headers: _authedHeaders)
        .then((response) {
      // print(response.statusCode);
      // print(response.body);
      return FoodItem.fromJson(json.decode(response.body));
        });
  }

  Future<void> swipeSubmit(int foodItem, Swipe swipe) {
    print('Swipe submit');
    return http.post(Uri.parse('$baseUri/swipe/submit'),
        headers: _authedHeaders,
        body: json.encode({
          'foodItem': foodItem,
          'swipe': swipe.name.toUpperCase(),
        })).then((value) {
      print('Hereeeeeea ');
      print(value.statusCode);
      print(value.body);
    }).catchError((e) {
      print('ttt'); 
      print(e);
    });
  }

  Future<void> startCart() {
    return http.post(Uri.parse('$baseUri/cart/start'), headers: _authedHeaders);
  }

  Future<List<FoodItem>> listCart() {
    return http
        .get(Uri.parse('$baseUri/cart/list'), headers: _authedHeaders)
        .then((response) {
      var json = jsonDecode(response.body) as List;
      return json.map((e) => FoodItem.fromJson(e)).toList();
    });
  }

  Future<FoodItem> cartNext() {
    return http
        .get(Uri.parse('$baseUri/cart/next'), headers: _authedHeaders)
        .then((response) => FoodItem.fromJson(jsonDecode(response.body)));
  }

  Future<void> cartSwipe(int foodItem, CartSwipe swipe) {
    return http.post(Uri.parse('$baseUri/cart/swipe'),
        headers: _authedHeaders,
        body: json.encode({
          'foodItem': foodItem,
          'swipe': swipe,
        }));
  }

  Future<void> cartRemove(String foodItem) {
    return http.delete(Uri.parse('$baseUri/cart/remove'),
        headers: _authedHeaders,
        body: json.encode({
          'foodItem': foodItem,
        }));
  }

  Future<List<FoodItem>> listDislikes() {
    return http
        .get(Uri.parse('$baseUri/user/dislikes'), headers: _authedHeaders)
        .then((response) {
      print(response.body);
      var json = jsonDecode(response.body) as List;
      return json.map((e) => FoodItem.fromJson(e)).toList();
    });
  }
}

final tt = {0: "0.jpg",
  1: "1.jpg",
  1006: "1006.jpg",
  1007: "1007.jpg",
  1009: "1009.jpg",
  1011: "1011.jpg",
  1016: "1016.PNG",
  1022: "1022.PNG",
  1029: "1029.jpg",
  1042: "1042.jpg",
  1043: "1043.jpg",
  1044: "1044.jpg",
  1071: "1071.PNG",
  1072: "1072.jpeg",
  1073: "1073.PNG",
  1083: "1083.jpg",
  1088: "1088.PNG",
  1090: "1090.PNG",
  1091: "1091.PNG",
  1100: "1100.jpg",
  1102: "1102.jpg",
  1118: "1118.PNG",
  1119: "1119.PNG",
  1120: "1120.jpg",
  1121: "1121.jpg",
  1122: "1122.jpg",
  1133: "1133.jpg",
  1134: "1134.jpg",
  1135: "1135.jpg",
  1146: "1146.PNG",
  1147: "1147.PNG",
  1148: "1148.PNG",
  1149: "1149.png",
  1158: "1158.jpg",
  1159: "1159.jpg",
  1160: "1160.jpg",
  132: "132.PNG",
  136: "136.PNG",
  143: "143.png",
  161: "161.png",
  2: "2.png",
  205: "205.png",
  206: "206.png",
  207: "207.jpg",
  208: "208.jpg",
  209: "209.jpg",
  213: "213.jpg",
  215: "215.jpg",
  216: "216.jpg",
  217: "217.jpg",
  220: "220.jpg",
  222: "222.jpg",
  223: "223.jpg",
  225: "225.PNG",
  226: "226.jpg",
  227: "227.jpg",
  228: "228.jpg",
  229: "229.jpg",
  230: "230.jpg",
  234: "234.jpg",
  235: "235.PNG",
  237: "237.jpg",
  239: "239.jpg",
  241: "241.jpg",
  242: "242.jpg",
  243: "243.PNG",
  244: "244.jpg",
  268: "268.jpg",
  283: "283.jpg",
  284: "284.jpg",
  296: "296.jpg",
  297: "297.jpg",
  3: "3.png",
  302: "302.jpg",
  305: "305.jpg",
  307: "307.jpg",
  308: "308.jpg",
  309: "309.jpg",
  310: "310.jpg",
  311: "311.jpg",
  312: "312.jpg",
  313: "313.jpg",
  314: "314.jpg",
  315: "315.jpg",
  319: "319.jpg",
  321: "321.PNG",
  332: "332.jpg",
  333: "333.jpg",
  363: "363.jpg",
  364: "364.jpg",
  376: "376.PNG",
  377: "377.png",
  378: "378.png",
  379: "379.png",
  380: "380.png",
  401: "401.jpg",
  402: "402.jpg",
  42: "42.jpg",
  43: "43.jpg",
  436: "436.jpg",
  437: "437.jpg",
  44: "44.png",
  440: "440.png",
  449: "449.jpg",
  45: "45.png",
  454: "454.jpg",
  456: "456.jpg",
  457: "457.jpg",
  458: "458.png",
  459: "459.jpg",
  520: "520.jpg",
  527: "527.jpg",
  528: "528.PNG",
  532: "532.jpg",
  559: "559.jpg",
  560: "560.PNG",
  571: "571.jpeg",
  573: "573.PNG",
  579: "579.jpg",
  582: "582.PNG",
  583: "583.PNG",
  589: "589.jpg",
  59: "59.PNG",
  590: "590.jpg",
  591: "591.jpg",
  592: "592.PNG",
  596: "596.PNG",
  599: "599.PNG",
  626: "626.PNG",
  629: "629.PNG",
  631: "631.PNG",
  655: "655.jpg",
  657: "657.jpg",
  659: "659.jpg",
  660: "660.PNG",
  665: "665.jpg",
  666: "666.jpg",
  672: "672.jpg",
  676: "676.PNG",
  677: "677.jpeg",
  678: "678.PNG",
  679: "679.jpg",
  68: "68.PNG",
  709: "709.jpg",
  712: "712.jpg",
  713: "713.jpg",
  716: "716.jpg",
  718: "718.jpg",
  725: "725.PNG",
  730: "730.PNG",
  739: "739.PNG",
  742: "742.png",
  748: "748.jpg",
  749: "749.jpg",
  77: "77.png",
  78: "78.PNG",
  782: "782.jpg",
  80: "80.jpg",
  807: "807.jpg",
  81: "81.PNG",
  82: "82.jpg",
  829: "829.jpg",
  84: "84.jpg",
  848: "848.png",
  849: "849.jpg",
  850: "850.jpg",
  851: "851.png",
  852: "852.png",
  853: "853.png",
  854: "854.png",
  872: "872.PNG",
  873: "873.jpg",
  889: "889.jpg",
  890: "890.PNG",
  892: "892.PNG",
  893: "893.PNG",
  895: "895.jpg",
  897: "897.jpg",
  899: "899.jpg",
  900: "900.PNG",
  901: "901.PNG",
  904: "904.jpg",
  905: "905.jpg",
  913: "913.jpg",
  926: "926.jpg",
  927: "927.jpg",
  935: "935.PNG",
  936: "936.jpg",
  937: "937.PNG",
  938: "938.png",
  940: "940.jpg",
  941: "941.jpg",
  943: "943.PNG",
  945: "945.jpg",
  979: "979.jpg",
  983: "983.jpg",
  984: "984.jpg",
  985: "985.png",
  989: "989.PNG",
  990: "990.PNG", };

class User {
  String id;
  String firstName;
  String lastName;
  String email;
  List<String> allergens;
  List<String> intolerances;
  bool vegan;
  bool vegetarian;

  User(this.id, this.firstName, this.lastName, this.email, this.allergens,
      this.intolerances, this.vegan, this.vegetarian);

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        firstName = json['firstName'],
        lastName = json['lastName'],
        email = json['email'],
        allergens = json['allergens'] == null ? [] : (json['allergens'] as List).map((e) => e as String).toList(),
        intolerances = json['intolerances'] == null ? [] : (json['intolerances'] as List).map((e) => e as String).toList(),
        vegan = json['vegan'] ?? false,
        vegetarian = json['vegetarian'] ?? false;
}

class RegisterUser {
  String firstName;
  String lastName;
  String email;
  String password;
  List<String> allergens;
  List<String> intolerances;
  bool vegan;
  bool vegetarian;

  RegisterUser(this.firstName, this.lastName, this.email, this.password, this.allergens,
      this.intolerances, this.vegan, this.vegetarian);

  Map<String, dynamic> toJson() => {
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'allergens': allergens,
        'intolerances': intolerances,
        'vegan': vegan,
        'vegetarian': vegetarian,
      };
}

class UpdateUser {
  List<String> allergens;
  List<String> intolerances;
  bool vegan;
  bool vegetarian;

  UpdateUser(this.allergens, this.intolerances, this.vegan, this.vegetarian);

  Map<String, dynamic> toJson() => {
        'allergens': allergens,
        'intolerances': intolerances,
        'vegan': vegan,
        'vegetarian': vegetarian,
      };
}

class FoodItem {
  int id;
  String name;
  List<String> ingredients;
  List<String> allergens;
  String totalFat;
  String saturatedFat;
  String transFat;
  String cholesterol;
  String sodium;
  String totalCarbohydrate;
  String dietaryFiber;
  String totalSugars;
  String protein;
  int servingsPerContainer;
  String servingSize;
  int calories;
  double price;
  bool vegan;
  bool vegetarian;
  Location location;
  String image;

  FoodItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        ingredients = (json['ingredients'] as List<dynamic>).cast<String>().map((e) => e.trim()).toList(),
        allergens = (json['allergens'] as List<dynamic>).cast<String>().map((e) => e.trim()).toList(),
        totalFat = cleanData(json['totalFat']),
        saturatedFat = cleanData(json['saturatedFat']),
        transFat = cleanData(json['transFat']),
        cholesterol = cleanData(json['cholesterol']),
        sodium = cleanData(json['sodium']),
        totalCarbohydrate = cleanData(json['totalCarbohydrate']),
        dietaryFiber = cleanData(json['dietaryFiber']),
        totalSugars = cleanData(json['totalSugars']),
        protein = cleanData(json['protein']),
        // servingsPerContainer = json['servingsPerContainer'],
        servingsPerContainer = 1,
        // servingSize = json['servingSize'],
        servingSize = '1',
        calories = json['calories'],
        price = 0,
        vegan = json['vegan'],
        vegetarian = json['vegetarian'],
        location = Location.fromName(json['location']),
        image = tt.containsKey(int.tryParse(json['id']) ?? -1) ? 'images/${tt[json['id']]}' : 'images/image.jpg';

  @override
  String toString() {
    return 'FoodItem{id: $id, name: $name, ingredients: $ingredients, allergens: $allergens, totalFat: $totalFat, saturatedFat: $saturatedFat, transFat: $transFat, cholesterol: $cholesterol, sodium: $sodium, totalCarbohydrate: $totalCarbohydrate, dietaryFiber: $dietaryFiber, totalSugars: $totalSugars, protein: $protein, servingsPerContainer: $servingsPerContainer, servingSize: $servingSize, calories: $calories, price: $price, vegan: $vegan, vegetarian: $vegetarian, location: $location, image: $image}';
  }
}

String cleanData(String string) => string.split('\n')[0].split(' ').last;

enum Location {
  College_Grind('The College Grind'),
  Artesano('Artesano Bakery & Café'),
  Gracies('Gracie\'s'),
  Beanz('Beanz'),
  Solz('Sol\'s Underground'),
  Brick_City('Brick City Café'),
  Crossroads_Market('Café & Market at Crossroads'),
  Commons('The Commons'),
  Ctrl_Alt_Deli('Ctrl Alt Deli'),
  GV_Grill('Global Grille at Global Village'),
  Midnight_Oil('Midnight Oil'),
  RITz('RITz Sport Zone'),
  Salsaritas('Salsarita\'s at Global Village');

  final String displayName;

  const Location(this.displayName);

  static Location fromName(String name) =>
      Location.values.firstWhere((element) => element.name.toLowerCase() == name.toLowerCase());

  @override
  String toString() => name;
}

enum Swipe {
  like,
  dislike,
  superlike,
  superdislike;

  @override
  String toString() => name;
}

enum CartSwipe {
  add,
  ignore;

  @override
  String toString() => name;
}
