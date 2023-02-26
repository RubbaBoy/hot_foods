package is.yarr.hot_foods_backend.database;

import is.yarr.hot_foods_backend.entities.User;
import org.springframework.data.repository.CrudRepository;

import java.util.Optional;
import java.util.UUID;

public interface UserRepository extends CrudRepository<User, UUID>{
    Optional<User> findByEmailAndPassword(String email, String password);
}