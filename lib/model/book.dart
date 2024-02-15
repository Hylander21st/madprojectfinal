class Book {
 String uid;
 String author;
 String title;
 String description;
 Book({this.uid, this.author, this.title, this.description});
 Book.fromMap(Map<String, dynamic> data) {
 uid = data['uid'];
 author = data['author'];
 title = data['title'];
 description = data['description'];
 }
 Map<String, dynamic> toMap() {
 return {
 'uid': uid,
 'author': author,
 'title': title,
 'description': description
 };
 }
}