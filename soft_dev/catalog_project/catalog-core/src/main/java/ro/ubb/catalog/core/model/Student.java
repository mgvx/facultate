package ro.ubb.catalog.core.model;

import lombok.*;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Table;

/**
 * Created by pae.
 */

@Entity
@Table(name = "student")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Student extends User<Long> {

//    @Column(name = "email", nullable = false)
//    public String email;

    @Column(name = "name", nullable = false)
    private String name;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Student student = (Student) o;

        return name.equals(student.name);
    }

    @Override
    public String toString() {
        return "Student{" +
//                "email=" + email +
                ", name='" + name + '\'' +
                "} " + super.toString();
    }

}
