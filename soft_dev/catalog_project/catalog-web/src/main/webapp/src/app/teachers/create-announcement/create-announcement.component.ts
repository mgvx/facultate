import { Component, Input } from '@angular/core';
import { Router } from '@angular/router';
import {Location} from '@angular/common';

import { AlertService, UserService } from '../../_services/index';


import {AnnouncementService} from "../../announcements/shared/announcement.service";
import {Announcement} from "../../announcements/shared/announcement.model";


@Component({
    moduleId: module.id,
    templateUrl: './create-announcement.component.html',
})

export class CreateAnnouncementComponent {
    model: any = {};
    loading = false;


    @Input() announcement: Announcement;

    constructor(
                private announcementService: AnnouncementService,
                private router: Router,
                private location: Location,

                private alertService: AlertService) {
    }


    goBack(): void {
        this.location.back();
        // this.router.navigate(['/teacher/home/:id']);
    }

    createAnnouncement(title, descr) {
        this.loading = true;
        this.announcementService.create(title, descr)
            .subscribe(
                data => {
                    this.alertService.success('Created successful', true);
                    //this.router.navigate(['/teacher/home/:id']);
                },
                error => {

                    this.alertService.error(error);
                    this.loading = false;
                });
    }
}