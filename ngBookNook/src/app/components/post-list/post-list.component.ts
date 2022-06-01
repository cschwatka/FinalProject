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
  popularPosts: Post[] = [];

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
        this.posts = data; console.log(this.posts); this.popularPostRetrieval()},
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

  popularPostRetrieval() {

    this.popularPosts = this.posts.sort((a, b) => (b.comments.length - a.comments.length));

    this.popularPosts = this.popularPosts.slice(0,3);

  }

  checkUser(id: number, userId: number) {
    let user: User = new User();

    this.svc.showUser(userId).subscribe(
      (data) => user = data,
      (err) => console.log(err)
      )
    }

  usersFollowingAdd(userToFollowId: number) {
    let userDoingTheFollowing = localStorage.getItem("userId");
    let userDoingTheFollowingId = 0;
    let rejected = false;
    if (userToFollowId !== null && userDoingTheFollowing !== null && this.user !== null) {
      userDoingTheFollowingId = parseInt(userDoingTheFollowing);
      for (let userCheck of this.user.followedUsers) {
        if (userCheck.id === this.user.id) {
          rejected = true;
          break;
        }
      }
      if (rejected === false && userDoingTheFollowing !== null) {
        this.svc.addUserFollowing(userToFollowId, userDoingTheFollowingId, this.user).subscribe(
          (data) => {if (userToFollowId !== null && this.user !== null) {
             this.checkUser(userToFollowId, this.user.id);
          }},
          (err) => console.log(err)
        )


      }
  }




  // readingAdd(book: Book) {
  //   let userId = localStorage.getItem("userId");
  //   let id = 0;
  //   let rejected = false;
  //   if (userId !== null && this.user !== null) {
  //     id = parseInt(userId);
  //     for (let book1 of this.user.readingBooks) {
  //       if (book1.id === book.id) {
  //         rejected = true;
  //         break;
  //       }
  //     }
  //   }
  //   if (rejected === false && this.user !== null) {

  //    this.service.postReading(book, this.user.id).subscribe(
  //      (data) => {if (this.selected !== null && this.user !== null) {
  //         this.checkUser(this.selected.id, this.user.id);
  //      }},
  //      (err) => console.log(err)
  //    )
  //   }
  // }

}}
