package ro.ubb.catalog.web.dto;

import lombok.*;

/**
 * Created by pae.
 */

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
public class TeacherDto extends UserDto {
    private String name;
    private String email;
    private String password;


    @Override
    public String toString() {
        return "DescriptionDto{" +
                "email=" + email +
                "name='" + name + '\'' +
                "} " + super.toString();
    }
}
