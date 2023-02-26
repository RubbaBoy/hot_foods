package is.yarr.hot_foods_backend.database;

import is.yarr.hot_foods_backend.entities.Weights;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;
import java.util.UUID;

public interface WeightsRepository extends CrudRepository<Weights, Long>{
    
    Optional<Weights> findByUser(UUID user);
    
}
