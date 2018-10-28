import {NgModule}             from '@angular/core';
import {RouterModule, Routes} from '@angular/router';

import {StudentDetailComponent} from "./students/student-detail/student-detail.component";
import {StudentHomeComponent} from "./students/student-home/student-home.component";
import {StudentsComponent} from "./students/students.component";

import {TeacherDetailComponent} from "./teachers/teacher-detail/teacher-detail.component";
import {TeacherHomeComponent} from "./teachers/teacher-home/teacher-home.component";
import {TeachersComponent} from "./teachers/teachers.component";


import { HomeComponent } from './home/index';
import { LoginComponent } from './login/index';
import { RegisterComponent } from './register/index';
import { AuthGuard } from './_guards/index';
import {AnnouncementsComponent} from "./announcements/announcements.component";
import {AnnouncementDetailComponent} from "./announcements/announcement-detail/announcement-detail.component";
import {CreateAnnouncementComponent} from "./teachers/create-announcement/create-announcement.component";


const routes: Routes = [

    { path: 'login', component: LoginComponent },
    { path: 'register', component: RegisterComponent },
    { path: '', component: HomeComponent, canActivate: [AuthGuard] },


    // { path: '', redirectTo: '/home', pathMatch: 'full' },
    {path: 'students', component: StudentsComponent},
    {path: 'student/detail/:id', component: StudentDetailComponent},
    {path: 'student/home/:id', component: StudentHomeComponent},

    {path: 'teachers', component: TeachersComponent},
    {path: 'teacher/detail/:id', component: TeacherDetailComponent},
    {path: 'teacher/home/:id', component: TeacherHomeComponent},
    {path: 'teacher/home/:id/createAnnouncement', component:CreateAnnouncementComponent},

    {path: 'announcements', component: AnnouncementsComponent},
    {path: 'announcement/detail/:id', component: AnnouncementDetailComponent},


    // otherwise redirect to home
    { path: '**', redirectTo: '' }
];
@NgModule({
    imports: [RouterModule.forRoot(routes)],
    exports: [RouterModule]
})
export class AppRoutingModule {
}
