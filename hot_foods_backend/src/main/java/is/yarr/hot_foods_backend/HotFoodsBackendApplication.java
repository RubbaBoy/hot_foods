package is.yarr.hot_foods_backend;

import is.yarr.hot_foods_backend.database.FoodItemRepository;
import is.yarr.hot_foods_backend.dto.FoodItemDTO;
import is.yarr.hot_foods_backend.entities.FoodItem;
import is.yarr.hot_foods_backend.enums.DiningLocations;
import is.yarr.hot_foods_backend.scraper.Scraper;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;

import java.util.List;

@SpringBootApplication
@EntityScan({"is.yarr.hot_foods_backend.entities"})
public class HotFoodsBackendApplication {

//    private FoodItemRepository foodItemRepository;
//    public HotFoodsBackendApplication(FoodItemRepository foodItemRepository){
//        this.foodItemRepository = foodItemRepository;
//    }
    
    public static void main(String[] args) {
        SpringApplication.run(HotFoodsBackendApplication.class, args);
    }

//    @Override
//    public void run(String... args) throws Exception {
//        List<DiningLocations> locationsToGet = List.of(DiningLocations.values());
//
//        Scraper scraper = new Scraper();
//        int curIndex = 0;
//        for(var curLocation: locationsToGet) {
//            var scraped = scraper.scrapeForNutrition(curLocation, curIndex);
//            curIndex = scraped.index;
//            List<FoodItem> foods = scraped.foods;
//
//            foodItemRepository.saveAll(foods);
//        }
//    }

    public record ScraperReturn(List<FoodItem> foods, int index) {
    }
}
