import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fartmagazinetrial1/shared.dart';

class FirestoreService {
  var instance = FirebaseFirestore.instance.collection('users').doc(curUser.email).collection('allNotes');

  Future<void> addNote(String title, String content, {String path: ''}) async {
    await instance.doc(title).set({
      'title': title,
      'content': content,
      'path': path,
    });
  }

  Future<void> editNote(String title, String content, {String path: ''}) async {
    await instance.doc(title).update({
      'content': content,
      'path': path,
    });
  }

  Future<void> removeNote(String title) async {
    await instance.doc(title).delete();
  }
}
