import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';

import { AlertService, UserService } from '../_services/index';

import {Student} from "../students/shared/student.model";
import {StudentService} from "../students/shared/student.service";
import {TeacherService} from "../teachers/shared/teacher.service";
import {Teacher} from "../teachers/shared/teacher.model";


@Component({
    moduleId: module.id,
    templateUrl: 'register.component.html'
})

export class RegisterComponent {
    model: any = {};
    loading = false;

    @Input() student: Student;
    @Input() teacher: Teacher;

    constructor(
        private studentService: StudentService,
        private teacherService: TeacherService,

        private router: Router,
        private userService: UserService,
        private alertService: AlertService) { }


    goBack(): void {
        this.router.navigate(['/login']);
    }

    registerStudent(email, name, password) {
        this.loading = true;
        this.studentService.create(email,name,password)
            .subscribe(
                data => {
                    this.alertService.success('Registration successful', true);
                    this.router.navigate(['/login']);
                },
                error => {
                    this.alertService.error(error);
                    this.loading = false;
                });
    }
    registerTeacher(email, name, password) {
        this.loading = true;
        this.teacherService.create(email,name,password)
            .subscribe(
                data => {
                    this.alertService.success('Registration successful', true);
                    this.router.navigate(['/login']);
                },
                error => {
                    this.alertService.error(error);
                    this.loading = false;
                });
    }
}
