package is.yarr.hot_foods_backend.endpoints;

import is.yarr.hot_foods_backend.database.FoodItemRepository;
import is.yarr.hot_foods_backend.database.UserRepository;
import is.yarr.hot_foods_backend.database.WeightsRepository;
import is.yarr.hot_foods_backend.entities.Cart;
import is.yarr.hot_foods_backend.entities.FoodItem;
import is.yarr.hot_foods_backend.entities.User;
import is.yarr.hot_foods_backend.entities.Weights;
import is.yarr.hot_foods_backend.enums.Swipe;
import is.yarr.hot_foods_backend.services.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Optional;
import java.util.Random;
import java.util.UUID;

@Controller
public class SwipingController{
    private FoodItemRepository foodItemRepository;
    private final WeightsRepository weightsRepository;
    private UserRepository userRepository;
    private AuthService authService; 

    public SwipingController(FoodItemRepository foodItemRepository, WeightsRepository weightsRepository, UserRepository userRepository, AuthService authService){
        this.foodItemRepository = foodItemRepository;
        this.weightsRepository = weightsRepository;
        this.userRepository = userRepository;
        this.authService = authService;
    }
    
    @GetMapping("/swipe/next")
    public ResponseEntity<?> swipeNext(@RequestHeader String accessToken) {

        UUID userUuid = authService.getUser(accessToken);
        System.out.println("accessToken = " + accessToken);
        System.out.println("userUuid = " + userUuid);
        Optional<User> user = userRepository.findById(userUuid);
        System.out.println("user = " + user);

        if (user.isPresent()) {
            ArrayList<FoodItem> foods = new ArrayList();

            var iter = foodItemRepository.findAll();

            for (var cur : iter) {
                foods.add(cur);
            }

            Random random = new Random();
            FoodItem result;

            //get the weight map like a man
            System.out.println(user.get().getFirstName());
            
            var weightMap = weightsRepository.findByUser(user.get().getId()).orElseGet(() -> new Weights(user.get().getId(), new HashMap<>())).getWeightsMap();
            System.out.println("weightMap = " + weightMap);
//            System.out.println("foods = " + foods);
            

            //keep trying foods until its dietary compatable
            Collections.shuffle(foods);
            for (FoodItem currentFood : foods) {
                //check for dietary compatable and that it is not superdisliked(weight=-1)
                if (dietaryCompatable(user.get(), currentFood) && weightMap.getOrDefault(currentFood, 0.0)!=-1) {
                    return ResponseEntity.ok(currentFood);
                }
            }
        }
        return ResponseEntity.badRequest().build();
    }
        
    
    
    private boolean dietaryCompatable(User user, FoodItem foodItem){
//        System.out.println("user = " + user);
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
    
    record SubmitDTO(int foodItem, Swipe swipe) {}
    
    @PostMapping("/swipe/submit")
    public ResponseEntity<?> swipeSubmit(@RequestHeader String accessToken, @RequestBody SubmitDTO submitDTO){
        var swipe = submitDTO.swipe();
        var foodItem = submitDTO.foodItem();
        System.out.println("Here");
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);
        System.out.println("Submit");
        
        if(user.isPresent()){
            System.out.println("foodItem = " + foodItem);
            Optional<FoodItem> food = foodItemRepository.findById(foodItem);
            System.out.println("food = " + food);
            if(food.isPresent()) {
                //gets the weightsmap or creates a new one if one doesnt exist
                Weights weight = weightsRepository.findByUser(user.get().getId()).orElseGet(()->new Weights(user.get().getId(), new HashMap<>()));
                var weightMap = new HashMap<>(weight.getWeightsMap());
                //on like add 1
                if(swipe.equals(Swipe.LIKE)){
                    weightMap.compute(food.get(), (i, number)->{
                        if(number==null){
                            return 1.0;
                        } else {
                            return number+1;
                        }
                    });
                } else if (swipe.equals(Swipe.DISLIKE)) {
                    //on dislike, if greater than 0 subtract 1
                    weightMap.compute(food.get(), (i, number)->{
                        if(number==null){
                            return 0.0;
                        } else if(number > 0){
                            return number-1;
                        } else {
                            return 0.0;
                        }
                    });
                } else if (swipe.equals(Swipe.SUPERLIKE)){
                    //on super like add 3
                    weightMap.compute(food.get(), (i, number)->{
                        if(number==null){
                            return 3.0;
                        } else {
                            return number+3;
                        }
                    });
                } else if(swipe.equals(Swipe.SUPERDISLIKE)){
                    //set to -1 to ignore
                    weightMap.compute(food.get(), (i, number)->{
                       return -1.0;
                    });
                }

                System.out.println("weightMap = " + weightMap);
                weight.setWeightsMap(weightMap);
                weightsRepository.save(weight);
                
                return ResponseEntity.ok().build();
            }
        }

        System.out.println("bad");
        return ResponseEntity.badRequest().build();
    }
}