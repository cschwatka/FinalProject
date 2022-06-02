import { Router } from '@angular/router';
import { AuthService } from './../../services/auth.service';
import { Component, OnInit, ElementRef } from '@angular/core';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-login',
  templateUrl: './login.component.html',
  styleUrls: ['./login.component.css']
})
export class LoginComponent implements OnInit {

  loginUser: User = new User();

  constructor(private auth: AuthService, private router: Router, private elementRef: ElementRef) { }

  ngOnInit(): void {
    this.elementRef.nativeElement.ownerDocument
    .body.style.backgroundImage = 'url(assets/img/bn-bg.jpg)';
  }

  login(user: User) {
    console.log(user);
    this.auth.login(user.username, user.password).subscribe({
      next: (loggedInUser) => {
        this.router.navigateByUrl('/bookshelf');
      },
      error: (fail) => {
        console.error('LoginComponent.login(): login failed');
        console.error(fail);
      }
    })
  }

}
