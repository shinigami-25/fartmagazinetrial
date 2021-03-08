import 'dart:io';

import 'package:fartmagazinetrial1/shared.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageService {
  var bucket = FirebaseStorage.instance;
  Future<String> picFuture(String title) {
    return bucket.ref('users/${curUser.email}/$title.jpg').getDownloadURL();
  }

  Future<String> picFutureFromLink(String link) {
    return bucket.ref(link).getDownloadURL();
  }

  Future<void> addPic(String title, String path) async {
    if (path == '' || path == null) return;
    await bucket.ref('users/${curUser.email}/$title.jpg').putFile(File(path));
  }

  Future<void> removePic(String title) async {
    await bucket.ref('users/${curUser.email}/$title.jpg').delete();
  }
}
