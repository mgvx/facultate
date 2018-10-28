import {Injectable} from '@angular/core';
import {Http, Response, Headers} from "@angular/http";

import {Announcement} from './announcement.model'

import {Observable} from "rxjs";
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
import {Router} from "@angular/router";

@Injectable()

export class AnnouncementService{
    private announcementsUrl = 'http://localhost:8080/api/announcements';
    private headers = new Headers({'Content-Type': 'application/json'});

    constructor(
        private http: Http,
       // private router: Router
    ) {}

    getAnnouncements(): Observable<Announcement[]> {
        return this.http.get(this.announcementsUrl)
            .map(this.extractData)
            .catch(this.handleError);
    }

    private extractData(res: Response) {
        let body = res.json();
        return body.announcements || {};
    }

    private handleError(error: Response | any) {
        let errMsg: string;
        if (error instanceof Response) {
            const body = error.json() || '';
            const err = body.error || JSON.stringify(body);
            errMsg = `${error.status} - ${error.statusText || ''} ${err}`;
        } else {
            errMsg = error.message ? error.message : error.toString();
        }
        console.error(errMsg);
        return Observable.throw(errMsg);
    }

    getAnnouncement(id: number): Observable<Announcement> {
        return this.getAnnouncements()
            .map(announcements => announcements.find(announcement => announcement.id === id));
    }

    update(announcement): Observable<Announcement> {
        const url = `${this.announcementsUrl}/${announcement.id}`;
        return this.http
            .put(url, JSON.stringify({"announcement": announcement}), {headers: this.headers})
            .map(this.extractAnnouncementData)
            .catch(this.handleError);
    }

    private extractAnnouncementData(res: Response) {
        let body = res.json();
        return body.announcement || {};
    }

    create(title: string, descr : string ): Observable<Announcement> {
        let announcement  = {title,descr};
        return this.http
            .post(this.announcementsUrl, JSON.stringify({"announcement": announcement}), {headers: this.headers})
            .map(this.extractAnnouncementData)
            .catch(this.handleError);
    }

    delete(id: number): Observable<void> {
        const url = `${this.announcementsUrl}/${id}`;
        return this.http
            .delete(url, {headers: this.headers})
            .map(() => null)
            .catch(this.handleError);
    }
}