class Article {
 
 String author;
 String title;
 String description;
 Article({ this.author, this.title, this.description});
 Article.fromMap(Map<String, dynamic> data) {
 
 author = data['author'];
 title = data['title'];
 description = data['description'];
 }
 Map<String, dynamic> toMap() {
 return {

 'author': author,
 'title': title,
 'description': description
 };
 }
}