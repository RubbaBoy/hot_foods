package is.yarr.hot_foods_backend.scraper;

import is.yarr.hot_foods_backend.HotFoodsBackendApplication;
import is.yarr.hot_foods_backend.entities.FoodItem;
import is.yarr.hot_foods_backend.enums.DiningLocations;
import org.openqa.selenium.By;
import org.openqa.selenium.JavascriptExecutor;
import org.openqa.selenium.WebDriver;
import org.openqa.selenium.WebElement;
import org.openqa.selenium.chrome.ChromeDriver;
import org.openqa.selenium.support.ui.ExpectedConditions;
import org.openqa.selenium.support.ui.WebDriverWait;

import java.time.Duration;
import java.util.ArrayList;
import java.util.List;

public class Scraper {
    public boolean waitForElementByClassname(WebDriver driver, String elementClassName){
        try{
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofMillis(10000));
            WebElement element = wait.until(ExpectedConditions.visibilityOfElementLocated(By.className(elementClassName)));
            return true;
        } catch(Exception e){
            return false;
        }
    }

    public boolean waitForElementByCSSSelector(WebDriver driver, String cssSelector){
        try{
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofMillis(10000));
            WebElement element = wait.until(ExpectedConditions.visibilityOfElementLocated(By.cssSelector(cssSelector)));
            return true;
        } catch(Exception e){
            return false;
        }
    }

    public boolean waitForElementByXPath(WebDriver driver, String xPath){
        try {
            WebDriverWait wait = new WebDriverWait(driver, Duration.ofMillis(10000));
            WebElement element = wait.until(ExpectedConditions.visibilityOfElementLocated(By.xpath(xPath)));
            return true;
        } catch(Exception e){
            return false;
        }
    }

    public HotFoodsBackendApplication.ScraperReturn scrapeForNutrition(DiningLocations diningLocation, int index) throws InterruptedException {
        System.setProperty("webdriver.chrome.driver", "chromedriver.exe");
        WebDriver driver = new ChromeDriver();
        driver.get("https://www.rit.edu/fa/diningservices/netnutrition/1");

//        gets all the elements containing the names of the dining locations
        List<WebElement> diningFacilities = driver.findElements(By.className("unit__name-link"));

        String selectedFacility = diningLocation.getName();

        WebElement selectedDiningFacility = diningFacilities.stream().
                filter(i -> (i.getText().contains(selectedFacility))).findFirst().orElseThrow();

        selectedDiningFacility.click();

        //TODO maybe make it pick the correct day, foTr now just choosing the first day

        waitForElementByClassname(driver, "cbo_nn_menuLink");
        WebElement menuLink = driver.findElement(By.className("cbo_nn_menuLink"));
        menuLink.click();//open the daily menu for the dining location

        //now go through and get data from each section of the menu

        //grab all food subcategories
        waitForElementByCSSSelector(driver, "[role=\"treeitem\"]");
        List<WebElement> subFoodCategories = driver.findElements(By.cssSelector("[role=\"treeitem\"]"));
        //list to hold all the FoodItem objects
        List<FoodItem> foods = new ArrayList<>();

        for (WebElement curElement : subFoodCategories) {
            Thread.sleep(100);
            curElement.click();
        }

        waitForElementByClassname(driver, "cbo_nn_itemHover");
        List<WebElement> subCategoryFoodOptions = driver.findElements(By.className("cbo_nn_itemHover"));


        for (WebElement curFood : subCategoryFoodOptions) {
            //check for vegan/vegetarian img tags before clicking on the nutrition info
            List<WebElement> children = curFood.findElements(By.xpath(".//*"));
            
            boolean vegan = false;
            boolean vegetarian = false;
            for(WebElement curElement: children){
                if(curElement.getAttribute("title").equals("Vegetarian")){
                    vegetarian = true;
                }
                if(curElement.getAttribute("title").equals("Vegan")){
                    vegan = true;
                }
            }
            
            JavascriptExecutor js = (JavascriptExecutor) driver;
            js.executeScript("arguments[0].click();", curFood);

            //create the list of elements that contain each line of nutritional information
            waitForElementByClassname(driver, "cbo_nn_LabelBorderedSubHeader");
            List<WebElement> nutritionLines = driver.findElements(By.className("cbo_nn_LabelBorderedSubHeader"));

            waitForElementByClassname(driver, "cbo_nn_LabelHeader");
            String name = driver.findElement(By.className("cbo_nn_LabelHeader")).getText();
            
            if(waitForElementByXPath(driver, "//*[@id=\"nutritionLabel\"]/div/div/table/tbody/tr[4]/td/div[2]")) {
                int calories = Integer.parseInt(driver.findElement(By.xpath("//*[@id=\"nutritionLabel\"]/div/div/table/tbody/tr[4]/td/div[2]")).getText());
                
                waitForElementByClassname(driver, "cbo_nn_LabelIngredients");
                List<String> ingredients = List.of(driver.findElement(By.className("cbo_nn_LabelIngredients")).getText().split(",(?![^()]*+\\\\)"));

                waitForElementByClassname(driver, "cbo_nn_LabelAllergens");
                List<String> allergens = List.of(driver.findElement(By.className("cbo_nn_LabelAllergens")).getText().split(",(?![^()]*+\\\\)"));
                
                //create the food information object and add in the name/calories
                FoodItem currentFoodItem = new FoodItem();
                currentFoodItem.setName(name);
                currentFoodItem.setCalories(calories);
                currentFoodItem.setAllergens(allergens);
                currentFoodItem.setIngredients(ingredients);
                currentFoodItem.setVegan(vegan);
                currentFoodItem.setVegetarian(vegetarian);
                currentFoodItem.setId(index++);

                for (WebElement curNutritionLine : nutritionLines) {
                    boolean response = currentFoodItem.parseLineAndSet(curNutritionLine.getText());
                    if (!response)
                        System.out.println("FUCK SHIT FUCK SHIT FUCK SHIT");
                }

                System.out.println(currentFoodItem);
                //add to the overall foods list
                foods.add(currentFoodItem);
            }
            //close the popup
            waitForElementByXPath(driver, "//*[@id=\"btn_nn_nutrition_close\"]/span");
            WebElement exitButton = driver.findElement(By.xpath("//*[@id=\"btn_nn_nutrition_close\"]/span"));
            exitButton.click();
        }
        driver.quit();
        return new HotFoodsBackendApplication.ScraperReturn(foods, index);
    }
}