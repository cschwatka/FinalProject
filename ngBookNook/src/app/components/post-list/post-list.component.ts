import { BooknookService } from './../../services/booknook.service';
import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-post-list',
  templateUrl: './post-list.component.html',
  styleUrls: ['./post-list.component.css'],
})
export class PostListComponent implements OnInit {
  posts: Post[] = [];
  newPost: Post = new Post();
  user: User | null = null;
  popularPosts: Post[] = [];
  following: boolean = false;

  constructor(private svc: BooknookService) {}

  ngOnInit(): void {
    let id = localStorage.getItem('userId');
    if (id != null) {
      this.showUser(parseInt(id));
    }
    this.reload();
  }

  reloadPosts() {
    this.svc.showPostList().subscribe(
      (success) => (this.posts = success),
      (err) => console.log('Observable got an error ' + err)
    );

  }

  checkLists(post: Post): boolean {
    // console.log(this.user?.usersFollowing + "woof");
    // console.log(this.user?.followedUsers + "meow");

    if (this.user?.usersFollowing != null) {
        for (let user of this.user.usersFollowing) {
          if (user.id == post.user.id) {
            return false;
          }
        }
        // console.log(this.user.usersFollowing);
        console.log(this.user?.usersFollowing);
        return true;
      }

      return true;
  }

  showUser(id: number) {
    this.svc.showUser(id).subscribe(
      (data) => (this.user = data),
      (err) => console.log(err)
    );
  }

  reload() {
    this.posts = [];
    this.svc.showPostList().subscribe(

      (data) => { for (let post of data) {
        if (post.enabled === true) {
          this.posts.push(post);
        }
      }
        console.log(this.posts); this.popularPostRetrieval()},
      (err) => console.log(err)
    );
  }

  makePost() {
    if (this.user != null) {
      this.newPost.user = this.user;
    }
    this.svc.postPost(this.newPost).subscribe(
      (success) => {
        this.reload();
        this.newPost = new Post();
      },
      (err) => console.log(err)
    );
  }

  commentCount(post: Post): number {
    let count = 0;
    for (let comment of post.comments) {
      if (comment.enabled === true) {
        count++;
      }
    }
    return count;
  }

  removePost(post: Post) {
    this.svc.removePost(post.id).subscribe(
      (success) => {this.reload();},
      (err) => console.log(err)
    )
  }

  popularPostRetrieval() {
    this.popularPosts = this.posts.sort(
      (a, b) => b.comments.length - a.comments.length
    );

    this.popularPosts = this.popularPosts.slice(0, 3);
  }

  checkUser(id: number, userId: number) {
    this.svc.showUser(userId).subscribe(
      (data) => (this.user = data),
      (err) => console.log(err)
    );
  }

//   refresh(): void {
//     window.location.reload();
// }

  usersFollowingAdd(userToFollowId: number) {
    let userDoingTheFollowing = localStorage.getItem('userId');
    let userDoingTheFollowingId = 0;
    let rejected = false;
    if (
      userToFollowId !== null &&
      userDoingTheFollowing !== null &&
      this.user !== null
    ) {
      userDoingTheFollowingId = parseInt(userDoingTheFollowing);
      for (let userCheck of this.user.followedUsers) {
        if (userCheck.id === this.user.id) {
          rejected = true;
          break;
        }
      }
      if (rejected === false && userDoingTheFollowing !== null) {
        this.svc
          .addUserFollowing(userToFollowId, userDoingTheFollowingId, this.user)
          .subscribe(
            (data) => {
              if (userToFollowId !== null && this.user !== null) {
                this.checkUser(userToFollowId, this.user.id);
                // this.refresh();
              }
            },
            (err) => console.log(err)
          );
      }
    }
  }

  usersFollowingRemove(userToFollowId: number) {
    let userDoingTheFollowing = localStorage.getItem('userId');
    let userDoingTheFollowingId = 0;
    let rejected = false;
    if (
      userToFollowId !== null &&
      userDoingTheFollowing !== null &&
      this.user !== null
    ) {
      userDoingTheFollowingId = parseInt(userDoingTheFollowing);
      for (let userCheck of this.user.followedUsers) {
        if (userCheck.id === this.user.id) {
          rejected = true;
          break;
        }
      }
      if (rejected === false && userDoingTheFollowing !== null) {
        this.svc
          .removeUserFollowing(userToFollowId, userDoingTheFollowingId)
          .subscribe(
            (data) => {
              if (userToFollowId !== null && this.user !== null) {
                this.checkUser(userToFollowId, this.user.id);
                // this.refresh();
              }
            },
            (err) => console.log(err)
          );
      }
    }
  }


}
