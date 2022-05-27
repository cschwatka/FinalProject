import { User } from "./user";

export class CommentVote {
  id: number;
  vote: boolean;
  user: User;
  comment: Comment;

  constructor (
    id: number = 0,
    vote: boolean = false,
    user: User = new User(),
    comment: Comment = new Comment()
    ){
      this.id = id;
      this.vote = vote;
      this.user = user;
      this.comment = comment
   }
}
