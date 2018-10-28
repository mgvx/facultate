import {Component, Input, OnInit} from '@angular/core';
import {ActivatedRoute, Params} from "@angular/router";
import {Location} from '@angular/common';

import 'rxjs/add/operator/switchMap';

import {Teacher} from "../shared/teacher.model";
import {TeacherService} from "../shared/teacher.service";


@Component({
    selector: 'ubb-teacher-detail',
    templateUrl: './teacher-detail.component.html',
    styleUrls: ['./teacher-detail.component.css'],
})

export class TeacherDetailComponent implements OnInit {

    @Input() teacher: Teacher;

    constructor(private teacherService: TeacherService,
                private route: ActivatedRoute,
                private location: Location) {
    }

    ngOnInit(): void {
        this.route.params
            .switchMap((params: Params) => this.teacherService.getTeacher(+params['id']))
            .subscribe(teacher => this.teacher = teacher);
    }

    goBack(): void {
        this.location.back();
    }

    save(): void {
        this.teacherService.update(this.teacher)
            .subscribe(_ => this.goBack());
    }
}