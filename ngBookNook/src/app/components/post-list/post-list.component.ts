import { BooknookService } from './../../services/booknook.service';
import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';

@Component({
  selector: 'app-post-list',
  templateUrl: './post-list.component.html',
  styleUrls: ['./post-list.component.css']
})
export class PostListComponent implements OnInit {

  posts: Post[] = [];

  constructor(private svc: BooknookService) { }

  ngOnInit(): void {
    this.reload();
  }

  reload() {
    this.svc.showPostList().subscribe(
      (data) => {this.posts = data; console.log(this.posts)},
      (err) => console.log(err)
    )
  }

}
