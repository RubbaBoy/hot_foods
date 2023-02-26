package is.yarr.hot_foods_backend.endpoints;

import is.yarr.hot_foods_backend.database.UserRepository;
import is.yarr.hot_foods_backend.services.AuthService;
import org.springframework.http.HttpHeaders;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;

@Controller
public class LoginController{
    private UserRepository userRepository;
    private AuthService authService;
    
    public LoginController(UserRepository userRepository, AuthService authService){
        this.userRepository = userRepository;
        this.authService = authService;
    }
    
    @PostMapping("/auth/login")
    public ResponseEntity<?> login(@RequestBody LoginDTO loginDTO){
        var useroptional = userRepository.findByEmailAndPassword(loginDTO.email(), loginDTO.password());
        if(useroptional.isPresent()){
            HttpHeaders responseHeaders = new HttpHeaders();
            System.out.println("Here");
            responseHeaders.set("Access-Token", authService.addAuth(useroptional.get().getId()));
             return ResponseEntity.ok()
                     .headers(responseHeaders)
                     .body(useroptional.get());
        } else {
            System.out.println("else");
            return ResponseEntity.badRequest().build();
        }
    }
    
    record LoginDTO(String email, String password) {}
}