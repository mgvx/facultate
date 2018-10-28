package ro.ubb.catalog.web.dto;

import lombok.*;

import java.io.Serializable;

/**
 * Created by pae.
 */
@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class UserDto implements Serializable{
    private Long id;
}
