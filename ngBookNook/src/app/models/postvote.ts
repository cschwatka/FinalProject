export class Postvote {

  post: Post;
  vote: boolean;

  constructor(post: Post = {}, vote: boolean = true) {
    this.post = post;
    this.vote = vote;
  }

}
