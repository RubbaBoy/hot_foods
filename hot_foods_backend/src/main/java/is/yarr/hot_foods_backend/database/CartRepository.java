package is.yarr.hot_foods_backend.database;

import is.yarr.hot_foods_backend.entities.Cart;
import is.yarr.hot_foods_backend.entities.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;
import java.util.UUID;

//TODO might cause an error at runtime so add @id annotation to user field in cart if it does
public interface CartRepository extends CrudRepository<Cart, Long>{
    Optional<Cart> findByUser(User user);
}