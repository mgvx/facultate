"use strict";
var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var core_1 = require('@angular/core');
require('rxjs/add/operator/switchMap');
var StudentHomeComponent = (function () {
    function StudentHomeComponent(studentService, route, location) {
        this.studentService = studentService;
        this.route = route;
        this.location = location;
    }
    StudentHomeComponent.prototype.ngOnInit = function () {
        var _this = this;
        this.route.params
            .switchMap(function (params) { return _this.studentService.getStudent(+params['id']); })
            .subscribe(function (student) { return _this.student = student; });
    };
    StudentHomeComponent.prototype.goBack = function () {
        this.location.back();
    };
    __decorate([
        core_1.Input()
    ], StudentHomeComponent.prototype, "student", void 0);
    StudentHomeComponent = __decorate([
        core_1.Component({
            selector: 'ubb-student-home',
            templateUrl: './student-home.component.html',
        })
    ], StudentHomeComponent);
    return StudentHomeComponent;
}());
exports.StudentHomeComponent = StudentHomeComponent;
