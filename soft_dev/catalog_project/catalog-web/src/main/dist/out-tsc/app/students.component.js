var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { Component } from '@angular/core';
import { StudentService } from "./student.service";
import { Router } from "@angular/router";
export var StudentsComponent = (function () {
    function StudentsComponent(studentService, router) {
        this.studentService = studentService;
        this.router = router;
    }
    StudentsComponent.prototype.ngOnInit = function () {
        this.getStudents();
    };
    StudentsComponent.prototype.getStudents = function () {
        var _this = this;
        // this.studentService.getStudents().then(students => this.students = students);
        this.studentService.getStudents()
            .subscribe(function (students) { return _this.students = students; }, function (error) { return _this.errorMessage = error; });
    };
    StudentsComponent.prototype.onSelect = function (student) {
        this.selectedStudent = student;
    };
    StudentsComponent.prototype.gotoDetail = function () {
        this.router.navigate(['/detail', this.selectedStudent.id]);
    };
    StudentsComponent = __decorate([
        Component({
            moduleId: module.id,
            selector: 'my-students',
            templateUrl: './students.component.html',
            styleUrls: ['./students.component.css'],
        }), 
        __metadata('design:paramtypes', [StudentService, Router])
    ], StudentsComponent);
    return StudentsComponent;
}());
//# sourceMappingURL=/home/radu/files/workspaces/workspace_2017/catalog4/catalog-web/src/main/webapp/app/students.component.js.map