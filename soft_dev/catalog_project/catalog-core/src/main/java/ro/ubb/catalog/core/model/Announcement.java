package ro.ubb.catalog.core.model;

import lombok.*;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by hd on 28-May-17.
 */

@Entity
@Table(name="announcement")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class Announcement implements Serializable {

    @Id
    @TableGenerator(name = "TABLE_GENERATOR2", initialValue = 0, allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GENERATOR2")
    @Column(unique = true, nullable = false)
    private long id;

    @Column(name="title",nullable = false)
    public String title;

    @Column(name="descr")
    public String descr;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Announcement a = (Announcement) o;

        return title.equals(a.title);
    }

    @Override
    public String toString() {
        return "Announcement{" +
                ", title='" + title + '\'' +
                ", description='"+ descr + '\'' +
                "} ";
    }


}
