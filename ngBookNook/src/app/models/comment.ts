import { ContentChild } from "@angular/core";
import { CommentVote } from "./comment-vote";
import { Post } from "./post";
import { User } from "./user";

export class Comment {
  id: number;
  content: string;
  commentDate: string;
  enabled: boolean;
  user: User;
  post: Post;
  comment: Comment;
  comments: Comment[];
  users: User[];
  commentVotes: CommentVote[];

  constructor(
    id: number = 0,
    content: string = '',
    commentDate: string = '',
    enabled: boolean = true,
    user: User = new User(),
    post: Post = new Post(),
    comment: Comment = new Comment(),
    comments: Comment[] = [],
    users: User[] = [],
    commentVotes: CommentVote[] = []
  ){
    this.id = id;
    this.content = content;
    this.commentDate = commentDate;
    this.enabled = enabled;
    this.user = user;
    this.post = post;
    this.comment = comment;
    this.comments = comments;
    this.users = users;
    this.commentVotes = commentVotes;

  }
}
