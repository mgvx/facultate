package ro.ubb.catalog.web.dto;

import lombok.*;

import java.io.Serializable;

/**
 * Created by hd on 28-May-17.
 */


@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder

public class AnnouncementDto implements Serializable{

    private Long id;
    private String title;
    private String descr;

    @Override
    public String toString(){
        return "Announcement{" +
                ", title='" + title + '\'' +
                ", description='"+ descr + '\'' +
                "} ";
    }

}
