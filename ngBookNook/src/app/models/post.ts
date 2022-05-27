import { User } from "./user";

export class Post {
  id: number;
  content: string;
  title: string;
  postDate: string;
  enabled: boolean;
  user: User;
  postVotes: PostVote[];
  comments: Comment[];

  constructor(

    id: number=0,
    content: string='',
    title: string='',
    postDate: string='',
    enabled: boolean=false,
    user: User = {},
    postVotes: PostVote[] = [],
    comments: Comment[] = []

  ) {

    this.id = id;
    this.content = content;
    this.title = title;
    this.postDate = postDate;
    this.enabled = enabled;
    this.user = user;
    this.postVotes = postVotes;
    this.comments = comments;

  }


}
