package ro.ubb.catalog.core.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ro.ubb.catalog.core.model.Teacher;
import ro.ubb.catalog.core.repository.TeacherRepository;
import ro.ubb.catalog.core.repository.TeacherRepository;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by pae.
 */

@Service
public class TeacherServiceImpl implements TeacherService {
    private static final Logger log = LoggerFactory.getLogger(TeacherServiceImpl.class);

    @Autowired
    private TeacherRepository teacherRepository;


    @Override
    public List<Teacher> findAll() {
        log.trace("findAll");
        List<Teacher> teachers = teacherRepository.findAll();
        log.trace("findAll: teachers={}", teachers);
        return teachers;
    }

    @Override
    public Teacher findTeacher(Long teacherId) {
        log.trace("findTeacher: teacherId={}", teacherId);
        Teacher teacher = teacherRepository.findOne(teacherId);
        log.trace("findTeacher: teacher={}", teacher);
        return teacher;
    }

    @Override
    public Teacher updateTeacher(Long teacherId, String name, String email, String password) {
        log.trace("updateTeacher: teacherId={}, name={}, email={}",teacherId, name, email);
        Teacher teacher = teacherRepository.findOne(teacherId);
        teacher.setName(name);
        teacher.setEmail(email);
        teacher.setPassword(password);
        log.trace("updateTeacher: teacher={}", teacher);
        return teacher;
    }

    @Override
    public Teacher createTeacher(String name, String email, String password) {
        log.trace("createTeacher: name={}",name);
        Teacher teacher = Teacher.builder()
                .name(name)
                .build();
        teacher.setEmail(email);
        teacher.setPassword(password);
        teacher = teacherRepository.save(teacher);
        log.trace("createTeacher: teacher={}", teacher);
        return teacher;
    }

    @Override
    public void deleteTeacher(Long teacherId) {
        log.trace("deleteTeacher: teacherId={}", teacherId);
        teacherRepository.delete(teacherId);
        log.trace("deleteTeacher - method end");
    }

}
