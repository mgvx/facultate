import {Component, Input, OnInit} from '@angular/core';
import {ActivatedRoute, Params} from "@angular/router";
import {Location} from '@angular/common';

import 'rxjs/add/operator/switchMap';

import {Announcement} from "../shared/announcement.model";
import {AnnouncementService} from "../shared/announcement.service";


@Component({
    selector: 'ubb-announcement-detail',
    templateUrl: './announcement-detail.component.html',

})

export class AnnouncementDetailComponent implements OnInit {

    @Input() announcement: Announcement;

    constructor(private announcementService: AnnouncementService,
                private route: ActivatedRoute,
                private location: Location) {
    }

    ngOnInit(): void {
        this.route.params
            .switchMap((params: Params) => this.announcementService.getAnnouncement(+params['id']))
            .subscribe(announcement => this.announcement = announcement);
    }

    goBack(): void {
        this.location.back();
    }

    save(): void {
        this.announcementService.update(this.announcement)
            .subscribe(_ => this.goBack());
    }
}