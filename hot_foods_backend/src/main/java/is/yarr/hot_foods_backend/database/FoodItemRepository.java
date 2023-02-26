package is.yarr.hot_foods_backend.database;

import is.yarr.hot_foods_backend.entities.FoodItem;
import org.springframework.data.repository.CrudRepository;

import java.util.UUID;

public interface FoodItemRepository extends CrudRepository<FoodItem, Integer>{
    
}