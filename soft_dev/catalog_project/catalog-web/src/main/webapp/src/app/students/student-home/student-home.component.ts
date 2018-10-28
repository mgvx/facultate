import {Component, Input, OnInit} from '@angular/core';
import {ActivatedRoute, Params} from "@angular/router";
import {Location} from '@angular/common';

import 'rxjs/add/operator/switchMap';

import {Student} from "../shared/student.model";
import {StudentService} from "../shared/student.service";
import {AnnouncementListComponent} from "../../announcements/announcement-list/announcement-list.component";

@Component({
    selector: 'ubb-student-home',
    templateUrl: './student-home.component.html',
})

export class StudentHomeComponent implements OnInit {

    @Input() student: Student;

    constructor(private studentService: StudentService,
                private route: ActivatedRoute,
                private location: Location) {
    }

    ngOnInit(): void {
        this.route.params
            .switchMap((params: Params) => this.studentService.getStudent(+params['id']))
            .subscribe(student => this.student = student);

    }

    goBack(): void {
        this.location.back();
    }

}