import { Component, OnInit } from '@angular/core';
import {Router, ActivatedRoute} from '@angular/router';

import { AlertService, AuthenticationService } from '../_services/index';
import {StudentService} from "../students/shared/student.service";
import {Student} from "../students/shared/student.model";
import {Teacher} from "../teachers/shared/teacher.model";
import {TeacherService} from "../teachers/shared/teacher.service";

@Component({
    moduleId: module.id,
    templateUrl: 'login.component.html'
})

export class LoginComponent implements OnInit {
    model: any = {};
    loading = false;
    returnUrl: string;

    students: Student[];
    teachers: Teacher[];

    constructor(
        private studentService: StudentService,
        private teacherService: TeacherService,


        private route: ActivatedRoute,
        private router: Router,
        private authenticationService: AuthenticationService,
        private alertService: AlertService) { }

    ngOnInit() {
        // reset login status
        this.authenticationService.logout();

        // get return url from route parameters or default to '/'
        this.returnUrl = this.route.snapshot.queryParams['returnUrl'] || '/';
    }


    goRegister(): void {
        this.router.navigate(['/register']);
    }

    // login(email, password) {
    //     this.loading = true;
    //     this.studentService.getStudents()
    //         .subscribe(
    //             students => this.students = students
    //         );
    //
    //     this.teacherService.getTeachers()
    //         .subscribe(
    //             teachers => this.teachers = teachers
    //         );
    //
    //
    //     for (var i = 0; i < this.students.length; i++) {
    //         if (this.students[i].email == email && this.students[i].password == password )
    //         {
    //             this.alertService.success('Logged In', true);
    //             this.router.navigate(['/student/home', this.students[i].id]);
    //             this.loading = false;
    //             return;
    //         }
    //     }
    //
    //     for (var i = 0; i < this.teachers.length; i++) {
    //         if (this.teachers[i].email == email && this.teachers[i].password == password )
    //         {
    //             this.alertService.success('Logged In', true);
    //             this.router.navigate(['/teacher/home', this.teachers[i].id]);
    //             this.loading = false;
    //             return;
    //         }
    //     }
    //     this.alertService.error('Login failed! Wrong user credentials', true);
    //     this.loading = false;
    //
    // }

    login(email, password) {
        this.loading = true;
        this.authenticationService.login(email, password)
            .subscribe(
                data => {
                    this.router.navigate([this.returnUrl]);
                },
                error => {
                    this.alertService.error(error._body);
                    this.loading = false;
                });

    }

}
