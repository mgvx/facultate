import {Injectable} from '@angular/core';
import {Http, Response, Headers} from "@angular/http";

import {Teacher} from "./teacher.model";

import {Observable} from "rxjs";
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';


@Injectable()
export class TeacherService {
    private teachersUrl = 'http://localhost:8080/api/teachers';
    private headers = new Headers({'Content-Type': 'application/json'});

    constructor(private http: Http) {
    }

    getTeachers(): Observable<Teacher[]> {
        return this.http.get(this.teachersUrl)
            .map(this.extractData)
            .catch(this.handleError);
    }

    private extractData(res: Response) {
        let body = res.json();
        return body.teachers || {};
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

    getTeacher(id: number): Observable<Teacher> {
        return this.getTeachers()
            .map(teachers => teachers.find(teacher => teacher.id === id));
    }

    update(teacher): Observable<Teacher> {
        const url = `${this.teachersUrl}/${teacher.id}`;
        return this.http
            .put(url, JSON.stringify({"teacher": teacher}), {headers: this.headers})
            .map(this.extractTeacherData)
            .catch(this.handleError);
    }

    private extractTeacherData(res: Response) {
        let body = res.json();
        return body.teacher || {};
    }

    create(email: string, name: string, password: string): Observable<Teacher> {
        let teacher = {email, name, password};
        return this.http
            .post(this.teachersUrl, JSON.stringify({"teacher": teacher}), {headers: this.headers})
            .map(this.extractTeacherData)
            .catch(this.handleError);
    }

    delete(id: number): Observable<void> {
        const url = `${this.teachersUrl}/${id}`;
        return this.http
            .delete(url, {headers: this.headers})
            .map(() => null)
            .catch(this.handleError);
    }

    validlogin(email: string, password: string): Observable<Teacher> {
        return this.getTeachers()
            .map(teachers => teachers.find(teacher => teacher.email === email && teacher.password === password));
    }
}
