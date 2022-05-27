export class Answer {
  id: number;
  content: string;
  answerDate: string;
  enabled: boolean;

  constructor(
    id: number = 0,
    content: string = '',
    answerDate: string = '',
    enabled: boolean = true
    ) {
      this.id = id;
      this.content = content;
      this.answerDate = answerDate;
      this.enabled = enabled;
    }
}
