package is.yarr.hot_foods_backend.endpoints;

import is.yarr.hot_foods_backend.database.UserRepository;
import is.yarr.hot_foods_backend.database.WeightsRepository;
import is.yarr.hot_foods_backend.entities.FoodItem;
import is.yarr.hot_foods_backend.entities.User;
import is.yarr.hot_foods_backend.entities.Weights;
import is.yarr.hot_foods_backend.services.AuthService;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;

import java.util.HashMap;
import java.util.List;
import java.util.Optional;
import java.util.UUID;

@Controller
public class UserController{
    private UserRepository userRepository;
    private AuthService authService;
    private WeightsRepository weightsRepository;

    public UserController(UserRepository userRepository, AuthService authService, WeightsRepository weightsRepository){
        this.userRepository = userRepository;
        this.authService = authService;
        this.weightsRepository = weightsRepository;
    }
    
    @PostMapping("/user/update")
    public ResponseEntity<?> updateUser(@RequestHeader String accessToken, @RequestBody List<String> allergens, 
                                        @RequestBody List<String> intolerances, @RequestBody boolean vegan, 
                                        @RequestBody boolean vegetarian){
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);
        
        if(user.isPresent()){
            user.get().setAllergen(allergens);
            user.get().setIntolerances(intolerances);
            user.get().setVegan(vegan);
            user.get().setVegetarian(vegetarian);
            
            return ResponseEntity.ok().build();
        } else {
            return ResponseEntity.badRequest().build();
        }
    }
    
    @GetMapping("/user/dislikes")
    public ResponseEntity<?> getDislikes(@RequestHeader String accessToken){
        UUID userUuid = authService.getUser(accessToken);
        Optional<User> user = userRepository.findById(userUuid);
        
        if(user.isPresent()){
            //gets the weightsmap or creates a new one if one doesnt exist
            Weights weights = weightsRepository.findByUser(user.get().getId()).orElseGet(()->new Weights(user.get().getId(), new HashMap<>()));
            var weightsMap = weights.getWeightsMap();
            List<FoodItem> foods = weightsMap.entrySet().stream().filter(i->i.getValue() == -1).map(i->i.getKey()).toList();
            return ResponseEntity.ok(foods);
        } else {
            return ResponseEntity.badRequest().build();
        }
    }
}