package ro.ubb.catalog.web.dto;

import lombok.*;

import java.util.Set;

/**
 * Created by hd on 28-May-17.
 */


@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString

public class AnnouncementsDto {
    private Set<AnnouncementDto> announcements;
}
