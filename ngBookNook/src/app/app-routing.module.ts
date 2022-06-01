import { PostListComponent } from './components/post-list/post-list.component';
import { BookPageComponent } from './components/book-page/book-page.component';
import { BookShelfComponent } from './components/book-shelf/book-shelf.component';
import { NotfoundComponent } from './components/notfound/notfound.component';
import { HomeComponent } from './components/home/home.component';
import { NgModule } from '@angular/core';
import { RouterModule, Routes } from '@angular/router';
import { RegisterComponent } from './components/register/register.component';
import { LoginComponent } from './components/login/login.component';
import { LogoutComponent } from './components/logout/logout.component';
import { MyAccountComponent } from './components/my-account/my-account.component';
import { PostViewComponent } from './components/post-view/post-view.component';

const routes: Routes = [
  { path: '', pathMatch: 'full', redirectTo: 'bookshelf' },
  { path: 'bookshelf', component: BookShelfComponent },
  { path: 'displaybook/:id', component: BookPageComponent },
  { path: 'myaccount/:bind', component: MyAccountComponent },
  { path: 'postlist', component: PostListComponent },
  { path: 'postview', component: PostViewComponent },
  { path: 'postview/:id', component: PostViewComponent },
  { path: 'postview/:id/:comments', component: PostViewComponent },
  { path: 'register', component: RegisterComponent },
  { path: 'login', component: LoginComponent },
  { path: 'logout', component: LogoutComponent },
  { path: '**', component: NotfoundComponent }

];

@NgModule({
  imports: [RouterModule.forRoot(routes, {useHash: true})],
  exports: [RouterModule]
})
export class AppRoutingModule { }

