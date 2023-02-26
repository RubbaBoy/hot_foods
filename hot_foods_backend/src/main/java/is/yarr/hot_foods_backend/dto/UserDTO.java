package is.yarr.hot_foods_backend.dto;

public class UserDTO {
    private String id;
    private String firstName;
    private String lastName;
    private String email;
    private String[] allergens;
    private String[] intolerances;
    private boolean vegan;
    private boolean vegetarian;
    
    public UserDTO() {}

    public UserDTO(String id, String firstName, String lastName, String email, String[] allergens, String[] intolerances, boolean vegan, boolean vegetarian) {
        this.id = id;
        this.firstName = firstName;
        this.lastName = lastName;
        this.email = email;
        this.allergens = allergens;
        this.intolerances = intolerances;
        this.vegan = vegan;
        this.vegetarian = vegetarian;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String[] getAllergens() {
        return allergens;
    }

    public void setAllergens(String[] allergens) {
        this.allergens = allergens;
    }

    public String[] getIntolerances() {
        return intolerances;
    }

    public void setIntolerances(String[] intolerances) {
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