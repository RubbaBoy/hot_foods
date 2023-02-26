package is.yarr.hot_foods_backend.endpoints;

import is.yarr.hot_foods_backend.database.UserRepository;
import is.yarr.hot_foods_backend.dto.RegisteredUserDTO;
import is.yarr.hot_foods_backend.entities.User;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

import java.util.List;
import java.util.Map;
import java.util.UUID;

@Controller
public class RegisterController{
    private UserRepository userRepository;
    
    public RegisterController(UserRepository userRepository){
        this.userRepository = userRepository;
    }
    
    @PostMapping("/auth/register")
    public ResponseEntity<?> registerUser(@RequestBody RegisteredUserDTO registeredUserDTO){
        System.out.println("/auth/register");
        System.out.println(registeredUserDTO.getPassword());
        User user = new User(UUID.randomUUID(), registeredUserDTO.getFirstName(), registeredUserDTO.getLastName(),
                registeredUserDTO.getPassword(), registeredUserDTO.getEmail(), registeredUserDTO.getAllergens(),
                registeredUserDTO.getIntolerances(), registeredUserDTO.isVegan(), registeredUserDTO.isVegetarian());
        
        userRepository.save(user);
        return ResponseEntity.ok(Map.of("id", user.getId()));
    }
    
}