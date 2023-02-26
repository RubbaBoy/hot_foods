package is.yarr.hot_foods_backend.entities;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name = "`users`")
public class User{
    @Id
    private UUID id;
    
    private String firstName;
    
    private String lastName;
    
    private String password;
    
    private String email;
    
    @ElementCollection
    private List<String> allergen;
    
    @ElementCollection
    private List<String> intolerances;
    
    private boolean vegan;
    
    private boolean vegetarian;
    
    public User() {}

    public User(UUID id, String firstName, String lastName, String password, String email, List<String> allergen, List<String> intolerances, boolean vegan, boolean vegetarian) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.password = password;
        this.email = email;
        this.allergen = allergen;
        this.intolerances = intolerances;
        this.vegan = vegan;
        this.vegetarian = vegetarian;
    }

    public UUID getId() {
        return id;
    }

    public void setId(UUID id) {
        this.id = id;
    }

    public String getFirstName() {
        return firstName;
    }

    public void setFirstName(String firstName) {
        this.firstName = firstName;
    }

    public String getLastName() {
        return lastName;
    }

    public void setLastName(String lastName) {
        this.lastName = lastName;
    }
    
    public String getPassword(){
        return password;
    }
    
    public void setPassword(String password){
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public List<String> getAllergen() {
        return allergen;
    }

    public void setAllergen(List<String> allergen) {
        this.allergen = allergen;
    }

    public List<String> getIntolerances() {
        return intolerances;
    }

    public void setIntolerances(List<String> intolerances) {
        this.intolerances = intolerances;
    }

    public boolean isVegan() {
        return vegan;
    }

    public void setVegan(boolean vegan) {
        this.vegan = vegan;
    }

    public boolean isVegetarian() {
        return vegetarian;
    }

    public void setVegetarian(boolean vegetarian) {
        this.vegetarian = vegetarian;
    }
}