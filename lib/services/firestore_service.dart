import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_firestoreapp/model/book.dart';
import 'package:firebase_firestoreapp/model/article.dart';

class FirestoreService {
  // Create a CollectionReference called bookCollection that references
  // the firestore collection
  final CollectionReference bookCollection =
      FirebaseFirestore.instance.collection('books');
  final CollectionReference reportsCollection =
      FirebaseFirestore.instance.collection('reports');

  Future<void> addBookData(
      String bookAuthor, String bookTitle, String bookDescription) async {
    var docRef = FirestoreService().bookCollection.doc();
    print('add docRef: ' + docRef.id);
    await bookCollection.doc(docRef.id).set({
      'uid': docRef.id,
      'author': bookAuthor,
      'title': bookTitle,
      'description': bookDescription
    });
  } //addBookData

  Future<void> addArticleData(
      String bookAuthor, String bookTitle, String bookDescription) async {
    var docRef = FirestoreService().bookCollection.doc();
    print('add docRef: ' + docRef.id);
    await bookCollection.doc(docRef.id).set({
      'uid': docRef.id,
      'author': bookAuthor,
      'title': bookTitle,
      'description': bookDescription
    });
  } //addBookData

  Future<List<Book>> readBookData() async {
    List<Book> bookList = [];
    QuerySnapshot snapshot = await bookCollection.get();
    snapshot.docs.forEach((document) {
      Book book = Book.fromMap(document.data());
      bookList.add(book);
    });
    print('Booklist: $bookList');
    return bookList;
  } //readBookData

  Future<void> deleteBookData(String docId) async {
    bookCollection.doc(docId).delete();
    print('deleting uid: ' + docId);
  } //deleteBookData

  //for your reference
  Future<void> updateBookData(
      String bookAuthor, String bookTitle, String bookDescription) async {
    var docRef = FirestoreService().bookCollection.doc();
    print('update docRef: ' + docRef.id);
    await bookCollection.doc(docRef.id).update({
      'uid': docRef.id,
      'author': bookAuthor,
      'title': bookTitle,
      'description': bookDescription
    });
  } //updateBookData

  //for your reference
  Future<void> deleteBookDoc() async {
    await bookCollection.get().then((snapshot) {
      for (DocumentSnapshot ds in snapshot.docs) {
        ds.reference.delete();
      }
    });
  } //deleteBookDoc

  Future<void> addReportData(
      String location, String description, String imageUrl) async {
    var docRef = FirestoreService().bookCollection.doc();
    print('add docRef: ' + docRef.id);
    await reportsCollection.doc(docRef.id).set({
      'location': location,
      'description': description,
      'imageUrl': imageUrl,
      'timestamp':
          FieldValue.serverTimestamp(), // Add timestamp for sorting purposes
    });
  }
} //FirestoreService
