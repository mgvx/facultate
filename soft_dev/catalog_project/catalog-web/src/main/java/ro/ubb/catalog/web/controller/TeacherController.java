package ro.ubb.catalog.web.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import ro.ubb.catalog.core.model.Teacher;
import ro.ubb.catalog.core.service.TeacherService;
import ro.ubb.catalog.web.converter.TeacherConverter;
import ro.ubb.catalog.web.dto.EmptyJsonResponse;
import ro.ubb.catalog.web.dto.TeacherDto;
import ro.ubb.catalog.web.dto.TeachersDto;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by hd.
 */

@RestController
public class TeacherController {

    private static final Logger log = LoggerFactory.getLogger(TeacherController.class);

    @Autowired
    private TeacherService teacherService;

    @Autowired
    private TeacherConverter teacherConverter;

    @RequestMapping(value = "/teachers", method = RequestMethod.GET)
    public TeachersDto getTeachers() {
        log.trace("getTeachers");
        List<Teacher> teachers = teacherService.findAll();
        log.trace("getTeachers: teachers={}", teachers);
        return new TeachersDto(teacherConverter.convertModelsToDtos(teachers));
    }

    @RequestMapping(value = "/teachers/{teacherId}", method = RequestMethod.PUT)
    public Map<String, TeacherDto> updateTeacher(
            @PathVariable final Long teacherId,
            @RequestBody final Map<String, TeacherDto> teacherDtoMap) {

        log.trace("updateTeacher: teacherId={}, teacherDtoMap={}", teacherId, teacherDtoMap);

        TeacherDto teacherDto = teacherDtoMap.get("teacher");
        Teacher teacher = teacherService.updateTeacher(teacherId, teacherDto.getName(), teacherDto.getEmail(), teacherDto.getPassword());

        Map<String, TeacherDto> result = new HashMap<>();
        result.put("teacher", teacherConverter.convertModelToDto(teacher));

        log.trace("updateTeacher: result={}", result);
        return result;
    }

    @RequestMapping(value = "/teachers", method = RequestMethod.POST)
    public Map<String, TeacherDto> createTeacher(
            @RequestBody final Map<String, TeacherDto> teacherDtoMap) {

        log.trace("createTeacher: teacherDtoMap={}", teacherDtoMap);

        TeacherDto teacherDto = teacherDtoMap.get("teacher");
        Teacher teacher = teacherService.createTeacher(teacherDto.getName(), teacherDto.getEmail(), teacherDto.getPassword());

        Map<String, TeacherDto> result = new HashMap<>();
        result.put("teacher", teacherConverter.convertModelToDto(teacher));

        log.trace("updateTeacher: result={}", result);
        return result;
    }

    @RequestMapping(value = "teachers/{teacherId}", method = RequestMethod.DELETE)
    public ResponseEntity deleteTeacher(@PathVariable final Long teacherId) {
        log.trace("deleteTeacher: teacherId={}", teacherId);

        teacherService.deleteTeacher(teacherId);

        log.trace("deleteTeacher - method end");
        return new ResponseEntity(new EmptyJsonResponse(), HttpStatus.OK);
    }
}
