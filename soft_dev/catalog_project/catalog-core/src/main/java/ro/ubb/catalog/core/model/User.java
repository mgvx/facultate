package ro.ubb.catalog.core.model;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by pae on 16.05.2017.
 */

@MappedSuperclass
public abstract class User<ID extends Serializable> implements Serializable {

    @Id
    @TableGenerator(name = "TABLE_GENERATOR", initialValue = 0, allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GENERATOR")
    @Column(unique = true, nullable = false)
    private ID id;


    @Column(name = "email", nullable = false)
    public String email;

    @Column(name = "password", nullable = false)
    public String password;


    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }

    public ID getId() {
        return id;
    }

    public void setId(ID id) {
        this.id = id;
    }

    @Override
    public String toString() {
        return "User{" +
                "id=" + id +
                '}';
    }
}
