package ro.ubb.catalog.core.service;

import ro.ubb.catalog.core.model.Student;

import java.util.List;

/**
 * Created by pae.
 */
public interface StudentService {
    List<Student> findAll();
    Student findStudent(Long studentId);
//    boolean validStudent(String studentName, String Password);
    Student updateStudent(Long studentId, String name, String email, String password);
    Student createStudent(String name, String email, String password);
    void deleteStudent(Long studentId);
    Student validlogin(String email,String password);
}
