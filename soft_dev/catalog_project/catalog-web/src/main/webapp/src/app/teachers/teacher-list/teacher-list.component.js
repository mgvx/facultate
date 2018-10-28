"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var core_1 = require('@angular/core');
var TeacherListComponent = (function () {
    function TeacherListComponent(teacherService, router) {
        this.teacherService = teacherService;
        this.router = router;
    }
    TeacherListComponent.prototype.ngOnInit = function () {
        this.getTeachers();
    };
    TeacherListComponent.prototype.getTeachers = function () {
        var _this = this;
        this.teacherService.getTeachers()
            .subscribe(function (teachers) { return _this.teachers = teachers; }, function (error) { return _this.errorMessage = error; });
    };
    TeacherListComponent.prototype.onSelect = function (teacher) {
        this.selectedTeacher = teacher;
    };
    TeacherListComponent.prototype.gotoDetail = function () {
        this.router.navigate(['/teacher/detail', this.selectedTeacher.id]);
    };
    TeacherListComponent = __decorate([
        core_1.Component({
            moduleId: module.id,
            selector: 'ubb-teacher-list',
            templateUrl: './teacher-list.component.html',
            styleUrls: ['./teacher-list.component.css'],
        })
    ], TeacherListComponent);
    return TeacherListComponent;
}());
exports.TeacherListComponent = TeacherListComponent;
