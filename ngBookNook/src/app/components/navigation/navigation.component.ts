import { BooknookService } from 'src/app/services/booknook.service';
import { Component, OnInit } from '@angular/core';
import { User } from 'src/app/models/user';
import { AuthService } from 'src/app/services/auth.service';

@Component({
  selector: 'app-navigation',
  templateUrl: './navigation.component.html',
  styleUrls: ['./navigation.component.css']
})
export class NavigationComponent implements OnInit {

  user: User | null = null;

  constructor(private auth: AuthService, private service: BooknookService) { }

  ngOnInit(): void {
    let id = localStorage.getItem("userId");

    if (id !== null) {
      this.showUser(parseInt(id));
    }
  }

  loggedIn(): boolean {
    return this.auth.checkLogin();
  }

  showUser(id: number) {
    this.service.showUser(id).subscribe(
      (data) => this.user = data,
      (err) => console.log(err)
    )
  }

}
