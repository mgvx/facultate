package ro.ubb.catalog.web.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import ro.ubb.catalog.core.model.Student;
import ro.ubb.catalog.web.dto.StudentDto;

import java.util.stream.Collectors;

/**
 * Created by hd.
 */

@Component
public class StudentConverter extends UserConverter<Student, StudentDto> {

    private static final Logger log = LoggerFactory.getLogger(StudentConverter.class);

    @Override
    public StudentDto convertModelToDto(Student student) {
        StudentDto studentDto = StudentDto.builder()
                .name(student.getName())
                .email(student.getEmail())
                .password(student.getPassword())
                .build();
        studentDto.setId(student.getId());
        return studentDto;
    }
}
