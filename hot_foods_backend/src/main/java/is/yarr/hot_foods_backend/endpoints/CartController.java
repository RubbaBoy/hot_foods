package is.yarr.hot_foods_backend.endpoints;

import is.yarr.hot_foods_backend.database.CartRepository;
import is.yarr.hot_foods_backend.database.FoodItemRepository;
import is.yarr.hot_foods_backend.database.UserRepository;
import is.yarr.hot_foods_backend.database.WeightsRepository;
import is.yarr.hot_foods_backend.entities.Cart;
import is.yarr.hot_foods_backend.entities.FoodItem;
import is.yarr.hot_foods_backend.entities.User;
import is.yarr.hot_foods_backend.enums.CartSwipe;
import is.yarr.hot_foods_backend.services.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;


import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;

@Controller
public class CartController{

    private UserRepository userRepository;
    private AuthService authService;
    private CartRepository cartRepository;
    private final FoodItemRepository foodItemRepository;
    private final WeightsRepository weightsRepository;

    public CartController(UserRepository userRepository, AuthService authService, CartRepository cartRepository,
                          FoodItemRepository foodItemRepository,
                          WeightsRepository weightsRepository){
        this.userRepository = userRepository;
        this.authService = authService;
        this.cartRepository = cartRepository;
        this.foodItemRepository = foodItemRepository;
        this.weightsRepository = weightsRepository;
    }
    
    @PostMapping("/cart/start")
    public ResponseEntity<?> startCart(@RequestHeader String accessToken){
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);

        if(user.isPresent()){
            Cart cart = cartRepository.findByUser(user.get()).orElseGet(()->new Cart(user.get(), new ArrayList<>()));
            var cartList = cart.getCart();
            cartList.clear();
            cart.setCart(cartList);
            cartRepository.save(cart);
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }
    
    @GetMapping("/cart/list")
    public ResponseEntity<?> listCart(@RequestHeader String accessToken){
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);

        if(user.isPresent()){
            Cart cart = cartRepository.findByUser(user.get()).orElseGet(()->new Cart(user.get(), new ArrayList<>()));
            var cartList = cart.getCart();
            return ResponseEntity.ok(cartList);
        } else {
            return ResponseEntity.badRequest().build();
        }
    }
    
    @GetMapping("/cart/next")
    public ResponseEntity<?> getNextCart(@RequestHeader String accessToken){
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);
        Random random = new Random();

        if(user.isPresent()){
            var weighted = weightsRepository.findByUser(user.get().getId());
            boolean flag = true;
            while(flag){
                if(weighted.isPresent()) {
                    double totalProb = 0;
                    var weightedElements = weighted.get().getWeightsMap();
                    for (FoodItem curFood : weightedElements.keySet()) {
                        totalProb += weightedElements.get(curFood);
                    }
    
                    int index = random.nextInt((int) totalProb);
                    int sum = 0;
                    int i = 0;
    
                    var weightedList = weightedElements.entrySet().stream().toList();
    
                    while (sum < index && i < weightedList.size()) {
                        if (weightedList.get(i) != null) {
                            sum += weightedElements.getOrDefault(weightedList.get(i), 0.0);
                        }
                        
                        i++;
                    }
    
                    FoodItem selected = weightedList.get(Math.max(0, i - 1)).getKey();
                    
                    //if is dietaryCompatable and weight isnt -1 then we can return the selected element
                    if (dietaryCompatable(user.get(), selected)) {
                        if (weightedElements.get(selected) != -1) {
                            return ResponseEntity.ok(selected);
                        }
                    }
                }
            }

        }
        return ResponseEntity.badRequest().build();
        
    }

    private boolean dietaryCompatable(User user, FoodItem foodItem){
        if(user.isVegan() && !foodItem.isVegan()){
            return false;
        }

        if(user.isVegetarian() && !foodItem.isVegetarian()){
            return false;
        }

        //for each allergy that the user has, check if the food item contains it
        for(String curAllergen: user.getAllergen()){
            if(foodItem.getAllergens().contains(curAllergen)){
                return false;
            }
        }
        return true;
    }
    
    @PostMapping("/cart/swipe")
    public ResponseEntity<?> swipeCart(@RequestHeader String accessToken, @RequestBody int foodItem, @RequestBody CartSwipe cartSwipe){
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);

        if(user.isPresent()){
            if(cartSwipe == CartSwipe.ADD){
                //add to cart
                Cart cart = cartRepository.findByUser(user.get()).orElseGet(()->new Cart(user.get(), new ArrayList<>()));
                var cartList = cart.getCart();
                
                Optional<FoodItem> food = foodItemRepository.findById(foodItem);
                if(food.isPresent()) {
                    cartList.add(food.get());
                    cart.setCart(cartList);
                    cartRepository.save(cart);
                } else {
                    return ResponseEntity.badRequest().build();
                }
            } else {
                //if cartSwipe == CartSwipe.IGNORE
                return ResponseEntity.ok().build();
            }
        }
        return ResponseEntity.badRequest().build();
    }
    
    @DeleteMapping
    public ResponseEntity<?> removeFromCart(@RequestHeader String accessToken, @RequestBody int foodItem){
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);
        
        if(user.isPresent()){
            
            Optional<FoodItem> food = foodItemRepository.findById(foodItem);
            
            if(food.isPresent()) {
                Cart cart = cartRepository.findByUser(user.get()).orElseGet(() -> new Cart(user.get(), new ArrayList<>()));
                var cartList = cart.getCart();

                cartList.remove(food.get());
                cart.setCart(cartList);
                cartRepository.save(cart);
                return ResponseEntity.ok().build();
            }
            
        }
        return ResponseEntity.badRequest().build();
    }
    
}