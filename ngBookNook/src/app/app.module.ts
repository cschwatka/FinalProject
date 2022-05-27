import { BooknookService } from './services/booknook.service';
import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { HttpClientModule } from '@angular/common/http';

import { AppRoutingModule } from './app-routing.module';
import { AppComponent } from './app.component';
import { NookComponent } from './components/nook/nook.component';
import { HomeComponent } from './components/home/home.component';
import { CommonModule, DatePipe } from '@angular/common';
import { FormsModule } from '@angular/forms';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { RegisterComponent } from './components/register/register.component';
import { NotfoundComponent } from './components/notfound/notfound.component';
import { NavigationComponent } from './components/navigation/navigation.component';
import { BookShelfComponent } from './components/book-shelf/book-shelf.component';

@NgModule({
  declarations: [
    AppComponent,
    NookComponent,
    BookShelfComponent,
    HomeComponent,
    LoginComponent,
    LogoutComponent,
    RegisterComponent,
    NotfoundComponent,
    NavigationComponent,
    BookShelfComponent
  ],
  imports: [
    BrowserModule,
    AppRoutingModule,
    HttpClientModule,
    FormsModule,
    CommonModule
  ],
  providers: [BooknookService,
              DatePipe
  ],
  bootstrap: [AppComponent,NookComponent,BookShelfComponent,HomeComponent,LoginComponent,LogoutComponent,RegisterComponent]
})
export class AppModule { }
