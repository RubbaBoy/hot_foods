package is.yarr.hot_foods_backend.dto;

import java.util.List;

public class RegisteredUserDTO {
    private String firstName;
    private String lastName;
    private String email;
    private String password;
    private List<String> allergens;
    private List<String> intolerances;
    private boolean vegan;
    private boolean vegetarian;
    
    public RegisteredUserDTO() {}

    public RegisteredUserDTO(String firstName, String lastName, String email, String password, List<String> allergens, List<String> intolerances, boolean vegan, boolean vegetarian) {
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.password = password;
        this.allergens = allergens;
        this.intolerances = intolerances;
        this.vegan = vegan;
        this.vegetarian = vegetarian;
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<String> getAllergens() {
        return allergens;
    }

    public void setAllergens(List<String> allergens) {
        this.allergens = allergens;
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