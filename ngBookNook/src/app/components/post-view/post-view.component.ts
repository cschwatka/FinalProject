import { ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { BooknookService } from 'src/app/services/booknook.service';
import { ViewportScroller } from '@angular/common';
import { Comment } from 'src/app/models/comment';
import { User } from 'src/app/models/user';

@Component({
  selector: 'app-post-view',
  templateUrl: './post-view.component.html',
  styleUrls: ['./post-view.component.css']
})
export class PostViewComponent implements OnInit {

  selected: Post | null = null;
  comments: Comment[] = [];
  newComment: Comment = new Comment();
  user: User | null = null;
  popularPosts: Post[] = [];
  posts: Post[] = [];

  constructor(private route: ActivatedRoute, private service: BooknookService, private scroller: ViewportScroller) { }

  ngOnInit(): void {
    if (!this.selected && this.route.snapshot.paramMap.get('id')) {
      let id = this.route.snapshot.paramMap.get('id');
      if (id) {
        this.show(parseInt(id));
      }
      if (this.route.snapshot.paramMap.get('comments') != null) {
        this.navigateToSection(this.route.snapshot.paramMap.get('comments'))
      }
    }
    let userId = localStorage.getItem("userId");
    if (userId != null) {
      this.showUser(parseInt(userId));
    }
    this.reload();
  }

  showUser(id: number){
    this.service.showUser(id).subscribe(
      (data) => {this.user = data;},
      (error) => console.log("Observable error showing book for selected book: " + error)
    )
  }

  show(id: number){
    this.service.showPost(id).subscribe(
      (data) => {this.selected = data; this.comments = data.comments; console.log(this.comments)},
      (error) => console.log("Observable error showing book for selected book: " + error)
    )
  }

  navigateToSection(section: string | null) {

    if (section != null) {
      this.scroller.scrollToAnchor(section);
    }
  }

  reload() {
    this.service.showPostList().subscribe(
      (data) => {
        this.posts = data; console.log(this.posts); this.popularPostRetrieval()},
      (err) => console.log(err)
    )
  }

  postComment() {
    if (this.selected != null && this.user != null) {
      this.service.postComment(this.newComment, this.selected.id, 0, this.user.id).subscribe(
        (success) => {if (this.selected != null) {
          this.show(this.selected.id)
          this.newComment = new Comment();
        }},
        (err) => console.log(err)

      )
    }

  }

  removeComment(comment: Comment) {
    this.service.removeComment(comment.id).subscribe(
      (success) => { if (this.selected !== null) {
        this.show(this.selected.id)
      }},
      (err) => console.log(err)
    )
  }

  commentCount(): number {
    let count = 0;
    for (let comment of this.comments) {
      if (comment.enabled === true) {
        count++;
      }
    }
    return count;
  }


  postCommentReply(comment: Comment) {
    if (this.selected != null && this.user != null) {
      this.service.postComment(this.newComment, this.selected.id, comment.id, this.user.id).subscribe(
        (success) => {if (this.selected != null) {
          this.show(this.selected.id)
          this.newComment = new Comment();
        }},
        (err) => console.log(err)

      )
    }

  }

  popularPostRetrieval() {

    this.popularPosts = this.posts.sort((a, b) => (b.comments.length - a.comments.length));

    this.popularPosts = this.popularPosts.slice(0,3);

  }

}
