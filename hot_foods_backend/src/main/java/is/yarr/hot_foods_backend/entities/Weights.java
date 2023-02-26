package is.yarr.hot_foods_backend.entities;

import javax.persistence.*;
import java.util.Map;
import java.util.UUID;

@Entity
@Table(name="`weights`")
public class Weights{
    //TODO autogenerate an id for this when it errors
    @Column(name = "`user_id`")
    private UUID user;

    @Id
    @GeneratedValue(strategy = GenerationType.TABLE)
    private Long id;
    
    @ElementCollection
    private Map<FoodItem, Double> weightsMap;
    
    public Weights(UUID user, Map<FoodItem, Double> weightsMap){
        this.user = user;
        this.weightsMap = weightsMap;
    }

    public Weights() {

    }
    
    public void setId(Long id) {
        this.id = id;
    }
    public Long getId() {
        return id;
    }
    
    public UUID getUser(){
        return user;
    }
    public void setUser(UUID user){
        this.user = user;
    }
    
    public Map<FoodItem, Double> getWeightsMap(){
        return weightsMap;
    }
    public void setWeightsMap(Map<FoodItem, Double> weightsMap){
        this.weightsMap = weightsMap;
    }
}