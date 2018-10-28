package ro.ubb.catalog.core.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import ro.ubb.catalog.core.model.Student;
import ro.ubb.catalog.core.repository.TeacherRepository;
import ro.ubb.catalog.core.repository.StudentRepository;

import java.util.List;
import java.util.Map;
import java.util.Set;

/**
 * Created by pae.
 */

@Service
public class StudentServiceImpl implements StudentService {
    private static final Logger log = LoggerFactory.getLogger(StudentServiceImpl.class);

    @Autowired
    private StudentRepository studentRepository;


    @Override
    public List<Student> findAll() {
        log.trace("findAll");
        List<Student> students = studentRepository.findAll();
        log.trace("findAll: students={}", students);
        return students;
    }

    @Override
    public Student findStudent(Long studentId) {
        log.trace("findStudent: studentId={}", studentId);
        Student student = studentRepository.findOne(studentId);
        log.trace("findStudent: student={}", student);
        return student;
    }
//
//    @Override
//    boolean validStudent(String studentName, String Password){
//        return true;
//    }

    @Override
    public Student updateStudent(Long studentId, String name, String email, String password) {
        log.trace("updateStudent: studentId={}, name={}, email={}",studentId, name, email);
        Student student = studentRepository.findOne(studentId);
        student.setName(name);
        student.setEmail(email);
        student.setPassword(password);
        log.trace("updateStudent: student={}", student);
        return student;
    }

    @Override
    public Student createStudent(String name, String email, String password) {
        log.trace("createStudent: name={}",name);
        Student student = Student.builder()
                .name(name)
                .build();
        student.setEmail(email);
        student.setPassword(password);
        student = studentRepository.save(student);
        log.trace("createStudent: student={}", student);
        return student;
    }

    @Override
    public void deleteStudent(Long studentId) {
        log.trace("deleteStudent: studentId={}", studentId);
        studentRepository.delete(studentId);
        log.trace("deleteStudent - method end");
    }

    @Override
    public Student validlogin(String email, String password) {
        //log.trace("findStudent: studentId={}", studentId);
//        List<Student> students = studentRepository.findAll();
//        Student student =  students.stream().findFirst( s -> s.getEmail() == email && s.getPassword() == password);
//        //log.trace("findStudent: student={}", student);
//        return student;
        return null;
    }

}
