package ro.ubb.catalog.web.converter;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Component;
import ro.ubb.catalog.core.model.Teacher;
import ro.ubb.catalog.web.dto.TeacherDto;

import java.util.stream.Collectors;

/**
 * Created by hd.
 */

@Component
public class TeacherConverter extends UserConverter<Teacher, TeacherDto> {

    private static final Logger log = LoggerFactory.getLogger(TeacherConverter.class);

    @Override
    public TeacherDto convertModelToDto(Teacher teacher) {
        TeacherDto teacherDto = TeacherDto.builder()
                .name(teacher.getName())
                .email(teacher.getEmail())
                .password(teacher.getPassword())
                .build();
        teacherDto.setId(teacher.getId());
        return teacherDto;
    }
}
