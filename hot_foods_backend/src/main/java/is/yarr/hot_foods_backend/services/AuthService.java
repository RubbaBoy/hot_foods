package is.yarr.hot_foods_backend.services;

import is.yarr.hot_foods_backend.entities.User;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

@Service
public class AuthService{
    private Map<String, UUID> authMap = new HashMap<>();
    
    public AuthService(){
    }
    
    public boolean verify(String authKey){
        System.out.println(authMap.get(authKey));
        
        return authMap.containsKey(authKey);
    }
    
    public UUID getUser(String authKey){
        return authMap.get(authKey);
    }
    
    public String addAuth(UUID uuid){
        String auth = String.valueOf(UUID.randomUUID());
        authMap.put(auth, uuid);
        return auth;
    }
}