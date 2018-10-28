"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var core_1 = require('@angular/core');
require('rxjs/add/operator/switchMap');
var TeacherDetailComponent = (function () {
    function TeacherDetailComponent(teacherService, route, location) {
        this.teacherService = teacherService;
        this.route = route;
        this.location = location;
    }
    TeacherDetailComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.route.params
            .switchMap(function (params) { return _this.teacherService.getTeacher(+params['id']); })
            .subscribe(function (teacher) { return _this.teacher = teacher; });
    };
    TeacherDetailComponent.prototype.goBack = function () {
        this.location.back();
    };
    __decorate([
        core_1.Input()
    ], TeacherDetailComponent.prototype, "teacher", void 0);
    TeacherDetailComponent = __decorate([
        core_1.Component({
            selector: 'ubb-teacher-detail',
            templateUrl: './teacher-detail.component.html',
            styleUrls: ['./teacher-detail.component.css'],
        })
    ], TeacherDetailComponent);
    return TeacherDetailComponent;
}());
exports.TeacherDetailComponent = TeacherDetailComponent;
