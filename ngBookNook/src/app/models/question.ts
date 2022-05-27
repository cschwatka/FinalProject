import { Answer } from "./answer";
import { User } from "./user";

export class Question {
  id: number;
  content: string;
  questionDate: string;
  user: User;
  answers: Answer[];

  constructor(
    id: number = 0,
    content: string = '',
    questionDate: string = '',
    user: User = new User(),
    answers: Answer[] = []
  ){
    this.id = id;
    this.content = content;
    this.questionDate = questionDate;
    this.user = user;
    this.answers = answers
  }
}
