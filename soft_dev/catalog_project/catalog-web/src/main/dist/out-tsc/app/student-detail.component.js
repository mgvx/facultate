var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { Component, Input } from '@angular/core';
import { Student } from "./student";
import { StudentService } from "./student.service";
import { ActivatedRoute } from "@angular/router";
import { Location } from '@angular/common';
import 'rxjs/add/operator/switchMap';
export var StudentDetailComponent = (function () {
    function StudentDetailComponent(studentService, route, location) {
        this.studentService = studentService;
        this.route = route;
        this.location = location;
    }
    StudentDetailComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.route.params
            .switchMap(function (params) { return _this.studentService.getStudent(+params['id']); })
            .subscribe(function (student) { return _this.student = student; });
    };
    StudentDetailComponent.prototype.goBack = function () {
        this.location.back();
    };
    __decorate([
        Input(), 
        __metadata('design:type', Student)
    ], StudentDetailComponent.prototype, "student", void 0);
    StudentDetailComponent = __decorate([
        Component({
            selector: 'my-student-detail',
            templateUrl: './student-detail.component.html'
        }), 
        __metadata('design:paramtypes', [StudentService, ActivatedRoute, Location])
    ], StudentDetailComponent);
    return StudentDetailComponent;
}());
//# sourceMappingURL=/home/radu/files/workspaces/workspace_2017/catalog4/catalog-web/src/main/webapp/app/student-detail.component.js.map