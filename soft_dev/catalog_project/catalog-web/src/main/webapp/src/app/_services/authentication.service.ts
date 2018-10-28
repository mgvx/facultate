import { Injectable } from '@angular/core';
import { Http, Headers, Response } from '@angular/http';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/map'
import {StudentService} from "../students/shared/student.service";
import {TeacherService} from "../teachers/shared/teacher.service";
import {Student} from "../students/shared/student.model";
import {Teacher} from "../teachers/shared/teacher.model";
import {AlertService} from "./alert.service";
import {Router} from "@angular/router";

@Injectable()
export class AuthenticationService {
    constructor(
        private studentService: StudentService,
        private teacherService: TeacherService,

        private router: Router,
        private alertService: AlertService,
        private http: Http) { }

    students: Student[];
    teachers: Teacher[];

    login(email: string, password: string) {



        this.studentService.getStudents()
            .subscribe(
                students => this.students = students
            );

        this.teacherService.getTeachers()
            .subscribe(
                teachers => this.teachers = teachers
            );


        for (var i = 0; i < this.students.length; i++) {
            if (this.students[i].email == email && this.students[i].password == password )
            {
                this.alertService.success('Logged In', true);
                this.router.navigate(['/student/home', this.students[i].id]);
                return;
            }
        }

        for (var i = 0; i < this.teachers.length; i++) {
            if (this.teachers[i].email == email && this.teachers[i].password == password )
            {
                this.alertService.success('Logged In', true);
                this.router.navigate(['/teacher/home', this.teachers[i].id]);
                return;
            }
        }
        this.alertService.error('Login failed! Wrong user credentials', true);


        return null;
        //
        // return null;
        // return this.http.post('/api/authenticate', JSON.stringify({ username: username, password: password }))
        //     .map((response: Response) => {
        //         // login successful if there's a jwt token in the response
        //         let user = response.json();
        //         if (user && user.token) {
        //             // store user details and jwt token in local storage to keep user logged in between page refreshes
        //             localStorage.setItem('currentUser', JSON.stringify(user));
        //         }
        //     });
    }

    logout() {
        // remove user from local storage to log user out
        localStorage.removeItem('currentUser');
    }
}