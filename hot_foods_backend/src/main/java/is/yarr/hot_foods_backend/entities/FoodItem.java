package is.yarr.hot_foods_backend.entities;


import is.yarr.hot_foods_backend.enums.DiningLocations;

import javax.persistence.ElementCollection;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import java.util.List;
import java.util.UUID;

@Entity
@Table(name="foods")
public class FoodItem{
    @Id
    private int id;

    private DiningLocations location;

    private String name;
    private int calories;
    private String totalFat;
    private String saturatedFat;
    private String transFat;
    private String cholesterol;
    private String sodium;
    private String totalCarbohydrate;
    private String dietaryFiber;
    private String totalSugars;
    private String protein;
    @ElementCollection
    private List<String> ingredients;
    @ElementCollection
    private List<String> allergens;
    private boolean isVegan;
    private boolean isVegetarian;

    public FoodItem(int id, DiningLocations location, String name, int calories, String totalFat, String saturatedFat, String transFat,
                    String cholesterol, String sodium, String totalCarbohydrate, String dietaryFiber, String totalSugars,
                    String protein, List<String> ingredients, List<String> allergens, boolean isVegan, boolean isVegetarian) {
        this.id = id;
        this.name = name;
        this.calories = calories;
        this.totalFat = totalFat;
        this.saturatedFat = saturatedFat;
        this.transFat = transFat;
        this.cholesterol = cholesterol;
        this.sodium = sodium;
        this.totalCarbohydrate = totalCarbohydrate;
        this.dietaryFiber = dietaryFiber;
        this.totalSugars = totalSugars;
        this.protein = protein;
        this.allergens = allergens;
        this.ingredients = ingredients;
        this.isVegan = isVegan;
        this.isVegetarian = isVegetarian;
        this.location = location;
    }

    public FoodItem(String name){
        this.name = name;
    }

    public FoodItem(){

    }

    public boolean parseLineAndSet(String param){
        if(param.toLowerCase().contains("total fat")){
            this.totalFat = param;
            return true;
        }
        if(param.toLowerCase().contains("saturated fat")){
            this.saturatedFat = param;
            return true;
        }
        if(param.toLowerCase().contains("trans fat")){
            this.transFat = param;
            return true;
        }
        if(param.toLowerCase().contains("cholesterol")){
            this.cholesterol = param;
            return true;
        }
        if(param.toLowerCase().contains("sodium")){
            this.sodium = param;
            return true;
        }
        if(param.toLowerCase().contains("total carbohydrate")){
            this.totalCarbohydrate = param;
            return true;
        }
        if(param.toLowerCase().contains("dietary fiber")){
            this.dietaryFiber = param;
            return true;
        }
        if(param.toLowerCase().contains("total sugars")){
            this.totalSugars = param;
            return true;
        }
        if(param.toLowerCase().contains("protein")){
            this.protein = param;
            return true;
        }

        return false;
    }

    public int getId(){
        return id;
    }

    public void setId(int id){
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public int getCalories() {
        return calories;
    }

    public String getTotalFat() {
        return totalFat;
    }

    public String getSaturatedFat() {
        return saturatedFat;
    }

    public String getTransFat() {
        return transFat;
    }

    public String getCholesterol() {
        return cholesterol;
    }

    public String getSodium() {
        return sodium;
    }

    public String getTotalCarbohydrate() {
        return totalCarbohydrate;
    }

    public String getDietaryFiber() {
        return dietaryFiber;
    }

    public String getTotalSugars() {
        return totalSugars;
    }

    public String getProtein() {
        return protein;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setCalories(int calories) {
        this.calories = calories;
    }

    public void setTotalFat(String totalFat) {
        this.totalFat = totalFat;
    }

    public void setSaturatedFat(String saturatedFat) {
        this.saturatedFat = saturatedFat;
    }

    public void setTransFat(String transFat) {
        this.transFat = transFat;
    }

    public void setCholesterol(String cholesterol) {
        this.cholesterol = cholesterol;
    }

    public void setSodium(String sodium) {
        this.sodium = sodium;
    }

    public void setTotalCarbohydrate(String totalCarbohydrate) {
        this.totalCarbohydrate = totalCarbohydrate;
    }

    public void setDietaryFiber(String dietaryFiber) {
        this.dietaryFiber = dietaryFiber;
    }

    public void setTotalSugars(String totalSugars) {
        this.totalSugars = totalSugars;
    }

    public void setProtein(String protein) {
        this.protein = protein;
    }

    public void setIngredients(List<String> ingredients){
        this.ingredients = ingredients;
    }
    public void setAllergens(List<String> allergens){
        this.allergens = allergens;
    }

    public List<String> getAllergens(){
        return this.allergens;
    }
    public List<String> getIngredients(){
        return this.ingredients;
    }

    public void setVegan(boolean isVegan){
        this.isVegan = isVegan;
    }
    public void setVegetarian(boolean isVegetarian){
        this.isVegetarian = isVegetarian;
    }

    public boolean isVegan(){
        return this.isVegan;
    }
    public boolean isVegetarian(){
        return this.isVegetarian;
    }

    public void setLocation(DiningLocations location){
        this.location = location;
    }

    public DiningLocations getLocation(){
        return this.location;
    }

}