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
public class StudentDto extends UserDto {
    private String name;
    private String email;
    private String password;

    @Override
    public String toString() {
        return "StudentDto{" +
                "email=" + email +
                ", name='" + name + '\'' +
                "} " + super.toString();
    }
}
