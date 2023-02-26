package is.yarr.hot_foods_backend.entities;

import javax.persistence.*;
import java.util.List;

@Entity
@Table(name="cart")
public class Cart{
    @OneToOne
    private User user;

    @Id
    @Column(name="testing")
    private Long id;
    
    @OneToMany
    private List<FoodItem> cart;
    
    public Cart(User user, List<FoodItem> cart){
        this.user = user;
        this.cart = cart;
    }
    
    public Cart() {
        
    }

    public Long getId() {
        return id;
    }

    public User getUser(){
        return user;
    }
    public void setUser(User user){
        this.user = user;
    }
    
    public List<FoodItem> getCart(){
        return cart;
    }
    public void setCart(List<FoodItem> cart){
       this.cart = cart;
    }
    
}