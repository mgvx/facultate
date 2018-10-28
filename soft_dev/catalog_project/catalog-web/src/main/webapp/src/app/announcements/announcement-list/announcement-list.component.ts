import {Component, OnInit} from '@angular/core';
import {Router} from "@angular/router";


import {Announcement} from '../shared/announcement.model'
import {AnnouncementService} from '../shared/announcement.service'


@Component({
    moduleId: module.id,
    selector: 'ubb-announcement-list',
    templateUrl: './announcement-list.component.html',
})


export class AnnouncementListComponent implements OnInit {
    errorMessage: string;
    announcements: Announcement[];
    selectedAnnouncement: Announcement;
    private announcement: Announcement;

    constructor(private announcementService: AnnouncementService,
                private router: Router) {
    }

    ngOnInit(): void {
        this.getAnnouncements();
    }

    getAnnouncements() {
        this.announcementService.getAnnouncements()
            .subscribe(
                announcements => this.announcements = announcements,
                error => this.errorMessage = <any>error
            );
    }

    onSelect(announcement: Announcement): void {
        this.selectedAnnouncement = announcement;
    }

    gotoDetail(): void {
        // this.router.navigate(['/announcement/detail', this.selectedAnnouncement.id]);
    }

    delete(announcement: Announcement): void {
        this.announcementService.delete(announcement.id)
            .subscribe(() => {
                this.announcements = this.announcements.filter(s => s !== announcement);
                if (this.selectedAnnouncement === announcement) {
                    this.selectedAnnouncement = null;
                }
            });
    }
}