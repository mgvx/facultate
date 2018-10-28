package ro.ubb.catalog.core.service;

import ro.ubb.catalog.core.model.Teacher;

import java.util.List;

/**
 * Created by pae.
 */

public interface TeacherService {
    List<Teacher> findAll();
    Teacher findTeacher(Long teacherId);
    Teacher updateTeacher(Long teacherId, String name, String email, String password);
    Teacher createTeacher(String name, String email, String password);
    void deleteTeacher(Long teacherId);
}
