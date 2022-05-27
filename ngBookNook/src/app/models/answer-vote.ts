import { Answer } from './answer';
import { User } from './user';
export class AnswerVote {

 id: number;
 vote: boolean;
 user: User;
 answer: Answer;

 constructor (
   id: number = 0,
   vote: boolean = false,
   user: User = {},
   answer: Answer = {}
   ){
     this.id = id;
     this.vote = vote;
     this.user = user;
     this.answer = answer
  }
}
