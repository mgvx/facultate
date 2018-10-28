import {Component, Input, OnInit} from '@angular/core';
import {ActivatedRoute, Params, Router} from "@angular/router";
import {Location} from '@angular/common';

import 'rxjs/add/operator/switchMap';

import {Teacher} from "../shared/teacher.model";
import {TeacherService} from "../shared/teacher.service";
import {AnnouncementListComponent} from "../../announcements/announcement-list/announcement-list.component";


@Component({
    selector: 'ubb-teacher-home',
    templateUrl: './teacher-home.component.html',
})

export class TeacherHomeComponent implements OnInit {

    @Input() teacher: Teacher;

    constructor(private teacherService: TeacherService,
                private route: ActivatedRoute,

                private router: Router,
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

    createAnnouncement():void{
        let currentUrl = this.router.url;
        this.router.navigate([currentUrl+'/createAnnouncement']);
    }

}