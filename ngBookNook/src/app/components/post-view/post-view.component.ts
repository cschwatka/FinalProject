import { ActivatedRoute } from '@angular/router';
import { Component, OnInit } from '@angular/core';
import { Post } from 'src/app/models/post';
import { BooknookService } from 'src/app/services/booknook.service';

@Component({
  selector: 'app-post-view',
  templateUrl: './post-view.component.html',
  styleUrls: ['./post-view.component.css']
})
export class PostViewComponent implements OnInit {

  selected: Post | null = null;

  constructor(private route: ActivatedRoute, private service: BooknookService) { }

  ngOnInit(): void {
    if (!this.selected && this.route.snapshot.paramMap.get('id')) {
      let id = this.route.snapshot.paramMap.get('id');
      if (id) {
        this.show(parseInt(id));
      }
      if (this.route.snapshot.paramMap.get('comments') != null) {
        this.navigateToSection(this.route.snapshot.paramMap.get('comments'))
      }
    }
  }

  show(id: number){
    this.service.showPost(id).subscribe(
      (data) => this.selected = data,
      (error) => console.log("Observable error showing book for selected book: " + error)
    )
  }

  navigateToSection(section: string | null) {

    if (section != null) {
      window.location.hash = '';
      window.location.hash = section;
    }
  }

}
