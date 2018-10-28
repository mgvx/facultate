import {BrowserModule} from '@angular/platform-browser';
import {NgModule} from '@angular/core';
import {FormsModule} from '@angular/forms';
import {HttpModule} from '@angular/http';

import {AppComponent} from './app.component';
import {AppRoutingModule} from "./app-routing.module";

import {StudentService} from "./students/shared/student.service";
import {StudentDetailComponent} from "./students/student-detail/student-detail.component";
import {StudentHomeComponent} from "./students/student-home/student-home.component";
import {StudentsComponent} from "./students/students.component";
import {StudentListComponent} from "./students/student-list/student-list.component";


import {AnnouncementService} from "./announcements/shared/announcement.service";
import {AnnouncementDetailComponent} from "./announcements/announcement-detail/announcement-detail.component";
// import {AnnouncementHomeComponent} from "./announcements/announcement-home/student-home.component";
import {AnnouncementsComponent} from "./announcements/announcements.component";
import {AnnouncementListComponent} from "./announcements/announcement-list/announcement-list.component";

import {TeacherService} from "./teachers/shared/teacher.service";
import {TeacherDetailComponent} from "./teachers/teacher-detail/teacher-detail.component";
import {TeacherHomeComponent} from "./teachers/teacher-home/teacher-home.component";
import {TeachersComponent} from "./teachers/teachers.component";
import {TeacherListComponent} from "./teachers/teacher-list/teacher-list.component";
import {CreateAnnouncementComponent} from "./teachers/create-announcement/create-announcement.component";


import { AlertComponent } from './_directives/index';
import { AuthGuard } from './_guards/index';
import { AlertService, AuthenticationService, UserService } from './_services/index';
import { HomeComponent } from './home/index';
import { LoginComponent } from './login/index';
import { RegisterComponent } from './register/index';



@NgModule({
    declarations: [
        AppComponent,

        StudentDetailComponent,
        StudentHomeComponent,
        StudentsComponent,
        StudentListComponent,

        TeacherDetailComponent,
        TeacherHomeComponent,
        TeachersComponent,
        TeacherListComponent,
        CreateAnnouncementComponent,

         AnnouncementDetailComponent,
         AnnouncementListComponent,
         AnnouncementsComponent,

        AlertComponent,
        HomeComponent,
        LoginComponent,
        RegisterComponent
    ],
    imports: [
        BrowserModule,
        FormsModule,
        HttpModule,
        AppRoutingModule,
    ],
    providers: [

        StudentService,
        AnnouncementService,
        TeacherService,

        AuthGuard,
        AlertService,
        AuthenticationService,
        UserService,
    ],
    bootstrap: [AppComponent]
})
export class AppModule {
}


