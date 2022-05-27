export class CommentVote {
  id: number;
  vote: boolean;
  user: User;
  comment: Commnet;

  constructor (
    id: number = 0,
    vote: boolean = false,
    user: User = {},
    comment: Comment = {}
    ){
      this.id = id;
      this.vote = vote;
      this.user = user;
      this.comment = comment
   }
}
