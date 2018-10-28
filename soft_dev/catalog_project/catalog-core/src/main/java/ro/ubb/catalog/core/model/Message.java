package ro.ubb.catalog.core.model;

import lombok.*;
import ro.ubb.catalog.core.repository.MessageRepository;

import javax.persistence.*;

/**
 * Created by hd on 28-May-17.
 */


@Entity
@Table(name="message")
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder

public  class Message {

    @Id
    @TableGenerator(name = "TABLE_GENERATOR3", initialValue = 0, allocationSize = 1)
    @GeneratedValue(strategy = GenerationType.TABLE, generator = "TABLE_GENERATOR3")
    @Column(unique = true, nullable = false)
    private long id;


    @Column(name="fromId",nullable = false)
    long fromId;

    @Column(name="toId",nullable = false)
    long toId;

    @Column(name="text",nullable = false)
    public String text;

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Message a = (Message) o;

        return id == a.getId();
    }

    @Override
    public String toString() {
        return "Announcement{" +
                ", text='" + text + '\'' +
                ", fromId ='"+ fromId + '\'' +
                ", toId ='"+ toId + '\'' +
                "} ";
    }


}
