export class Question {
  /*
  	private int id;

	private String content;

	@Column(name="question_date")
	@CreationTimestamp
	private LocalDateTime questionDate;

	private boolean enabled;

	@JsonIgnore
	@ManyToOne
	@JoinColumn(name="book_id")
	private Book book;

	@JsonIgnoreProperties({"usersFollowing","followedUsers", "users", "books","categories","authors",
		"reviews","answers","posts","comments","postVotes","commentVotes","answerVotes",
		"favoriteBooks", "finishedBooks", "readingBooks","wishlistBooks"})
	@ManyToOne
	@JoinColumn(name="user_id")
	private User user;

	@OneToMany(mappedBy="question")
	private List<Answer> answers;*/
  id: number;
  content: string;
  questionDate: string;
  user: User;
  answers: Answer[];

  constructor(
    id: number = 0,
    content: string = '',
    questionDate: string = '',
    user: User = {},
    answers: Answer[] = []
  ){
    this.id = id;
    this.content = content;
    this.questionDate = questionDate;
    this.user = user;
    this.answers = answers
  }
}
