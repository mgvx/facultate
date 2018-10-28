package ro.ubb.catalog.web.dto;

import lombok.*;

import java.io.Serializable;

/**
 * Created by hd on 06-Jun-17.
 */


@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder

public class MessageDto implements Serializable {

    private Long id;
    private String text;
    private Long toId;
    private Long fromId;

    @Override
    public String toString() {
        return "Announcement{" +
                ", text='" + text + '\'' +
                ", fromId ='"+ toId + '\'' +
                ", toId ='"+ fromId + '\'' +
                "} ";
    }

}
