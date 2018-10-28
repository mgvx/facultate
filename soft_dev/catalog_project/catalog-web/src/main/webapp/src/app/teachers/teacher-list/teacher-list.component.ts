import {Component, OnInit} from '@angular/core';
import {Router} from "@angular/router";

import {Teacher} from "../shared/teacher.model";
import {TeacherService} from "../shared/teacher.service";


@Component({
    moduleId: module.id,
    selector: 'ubb-teacher-list',
    templateUrl: './teacher-list.component.html',
    styleUrls: ['./teacher-list.component.css'],
})
export class TeacherListComponent implements OnInit {
    errorMessage: string;
    teachers: Teacher[];
    selectedTeacher: Teacher;

    constructor(private teacherService: TeacherService,
                private router: Router) {
    }

    ngOnInit(): void {
        this.getTeachers();
    }

    getTeachers() {
        this.teacherService.getTeachers()
            .subscribe(
                teachers => this.teachers = teachers,
                error => this.errorMessage = <any>error
            );
    }

    onSelect(teacher: Teacher): void {
        this.selectedTeacher = teacher;
    }

    gotoDetail(): void {
        this.router.navigate(['/teacher/detail', this.selectedTeacher.id]);
    }

    delete(teacher: Teacher): void {
        this.teacherService.delete(teacher.id)
            .subscribe(() => {
                this.teachers = this.teachers.filter(s => s !== teacher);
                if (this.selectedTeacher === teacher) {
                    this.selectedTeacher = null;
                }
            });
    }

}
