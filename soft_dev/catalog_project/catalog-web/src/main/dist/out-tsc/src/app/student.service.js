var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { Injectable } from '@angular/core';
import { Http, Response } from "@angular/http";
import 'rxjs/add/operator/toPromise';
import { Observable } from 'rxjs/Observable';
import 'rxjs/add/operator/catch';
import 'rxjs/add/operator/map';
export var StudentService = (function () {
    function StudentService(http) {
        this.http = http;
        this.studentsUrl = 'http://localhost:8080/students';
    }
    StudentService.prototype.getStudents = function () {
        // return Promise.resolve(STUDENTS);
        return this.http.get(this.studentsUrl)
            .map(this.extractData)
            .catch(this.handleError);
    };
    StudentService.prototype.extractData = function (response) {
        var body = response.json();
        return body.students || {};
    };
    StudentService.prototype.handleError = function (error) {
        var errMsg;
        if (error instanceof Response) {
            var body = error.json() || '';
            var err = body.error || JSON.stringify(body);
            errMsg = error.status + " - " + (error.statusText || '') + " " + err;
        }
        else {
            errMsg = error.message ? error.message : error.toString();
        }
        console.error(errMsg);
        return Observable.throw(errMsg);
    };
    StudentService.prototype.getStudent = function (id) {
        // return this.getStudents()
        //     .then(students => students.find(student => student.id === id));
        var url = this.studentsUrl + "/" + id;
        var p = this.http.get(url)
            .toPromise();
        return p
            .then(function (response) { return response.json().data; })
            .catch(this.handleError2);
        // return this.http.get(url)
        //     .map(response => response.json().data || {})
        //     .catch(this.handleError);
    };
    StudentService.prototype.handleError2 = function (error) {
        console.error('An error occurred', error); // for demo purposes only
        return Promise.reject(error.message || error);
    };
    StudentService = __decorate([
        Injectable(), 
        __metadata('design:paramtypes', [Http])
    ], StudentService);
    return StudentService;
}());
//# sourceMappingURL=/home/radu/files/workspaces/workspace_2017/catalog4/catalog-web/src/main/webapp/src/app/teacher.service.js.map