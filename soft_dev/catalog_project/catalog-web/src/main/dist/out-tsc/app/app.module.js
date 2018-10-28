var __decorate = (this && this.__decorate) || function (decorators, target, key, desc) {
    var c = arguments.length, r = c < 3 ? target : desc === null ? desc = Object.getOwnPropertyDescriptor(target, key) : desc, d;
    if (typeof Reflect === "object" && typeof Reflect.decorate === "function") r = Reflect.decorate(decorators, target, key, desc);
    else for (var i = decorators.length - 1; i >= 0; i--) if (d = decorators[i]) r = (c < 3 ? d(r) : c > 3 ? d(target, key, r) : d(target, key)) || r;
    return c > 3 && r && Object.defineProperty(target, key, r), r;
};
var __metadata = (this && this.__metadata) || function (k, v) {
    if (typeof Reflect === "object" && typeof Reflect.metadata === "function") return Reflect.metadata(k, v);
};
import { BrowserModule } from '@angular/platform-browser';
import { NgModule } from '@angular/core';
import { FormsModule } from '@angular/forms';
import { HttpModule } from '@angular/http';
import { AppComponent } from './app.component';
import { StudentDetailComponent } from "./student-detail.component";
import { StudentsComponent } from "./students.component";
import { StudentService } from "./student.service";
import { AppRoutingModule } from "./app-routing.module";
// import {InMemoryDataService} from "./in-memory-data.service";
// import { InMemoryWebApiModule } from 'angular-in-memory-web-api';
export var AppModule = (function () {
    function AppModule() {
    }
    AppModule = __decorate([
        NgModule({
            declarations: [
                AppComponent,
                StudentDetailComponent,
                StudentsComponent
            ],
            imports: [
                BrowserModule,
                FormsModule,
                HttpModule,
                // InMemoryWebApiModule.forRoot(InMemoryDataService),
                AppRoutingModule
            ],
            providers: [StudentService],
            bootstrap: [AppComponent]
        }), 
        __metadata('design:paramtypes', [])
    ], AppModule);
    return AppModule;
}());
//# sourceMappingURL=/home/radu/files/workspaces/workspace_2017/catalog4/catalog-web/src/main/webapp/app/app.module.js.map