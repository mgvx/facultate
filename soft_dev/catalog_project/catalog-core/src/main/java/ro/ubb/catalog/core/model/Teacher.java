package ro.ubb.catalog.core.model;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by pae on 16.05.2017.
 */
@Entity
@Table(name = "teacher")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Teacher extends User<Long> {

//    @Column(name = "email", nullable = false)
//    public String email;

    @Column(name = "name", nullable = false)
    private String name;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Teacher teacher = (Teacher) o;

        return name.equals(teacher.name);
    }

    @Override
    public String toString() {
        return "Teacher{" +
//                "email=" + email +
                ", name='" + name + '\'' +
                "} " + super.toString();
    }

}
