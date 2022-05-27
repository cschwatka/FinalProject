export class Author {
  id: number;
  enabled: boolean;
  fullName: string;

  constructor(

    id: number=0,
    enabled: boolean= true,
    fullName: string=''

  ) {

    this.id = id;
    this.enabled = enabled;
    this.fullName = fullName;

  }
}
