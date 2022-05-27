import { User } from './user';
export class AnswerVote {

 id: number;
 vote: boolean;
 user: User;
 answer: AnswerVote;

 constructor (
   id: number = 0,
   vote: boolean = false,
   user: User = {},
   answer: AnswerVote = {}
   ){
     this.id = id;
     this.vote = vote;
     this.user = user;
     this.answer = answer
  }
}
