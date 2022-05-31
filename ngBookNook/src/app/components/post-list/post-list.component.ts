import { BooknookService } from './../../services/booknook.service';
import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-post-list',
  templateUrl: './post-list.component.html',
  styleUrls: ['./post-list.component.css']
})
export class PostListComponent implements OnInit {

  posts: Post[] = [];
  newPost: Post = new Post();
  user: User | null = null;

  constructor(private svc: BooknookService) { }

  ngOnInit(): void {
    let id = localStorage.getItem("userId");
    if (id != null) {
      this.showUser(parseInt(id));
    }
    this.reload();
  }

  showUser(id: number) {

    this.svc.showUser(id).subscribe(
      (data) => this.user = data,
      (err) => console.log(err)
    )

  }

  reload() {
    this.svc.showPostList().subscribe(
      (data) => {
        this.posts = data; console.log(this.posts)},
      (err) => console.log(err)
    )
  }

  makePost() {
    if (this.user != null) {
      this.newPost.user = this.user;
    }
    this.svc.postPost(this.newPost).subscribe(
      (success) => {this.reload(); this.newPost = new Post()},
      (err) => console.log(err)
    )
  }

}
