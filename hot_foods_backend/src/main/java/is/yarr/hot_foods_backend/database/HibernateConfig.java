package is.yarr.hot_foods_backend.database;

import javax.persistence.EntityManager;
import javax.persistence.EntityManagerFactory;
import javax.persistence.Persistence;
import java.util.Map;

public class HibernateConfig {

    private static final EntityManagerFactory emf = Persistence.createEntityManagerFactory("is.yarr.Persistence");

    /**
     * The {@link EntityManager} provided by the {@link EntityManagerFactory}.
     *
     * @return The created {@link EntityManager}
     */
    public static EntityManager getEntityManager() {
        return emf.createEntityManager();
    }
}

