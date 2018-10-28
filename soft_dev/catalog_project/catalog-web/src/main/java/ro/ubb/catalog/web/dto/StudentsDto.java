package ro.ubb.catalog.web.dto;

import lombok.*;

import java.util.Set;

/**
 * Created by pae.
 */

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@Builder
@ToString
public class StudentsDto {
    private Set<StudentDto> students;
}
