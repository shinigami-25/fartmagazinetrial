import 'package:fartmagazinetrial1/services/firestoreService.dart';
import 'package:fartmagazinetrial1/widgets/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  List<Widget> notes = [];

  @override
  void onInit() {
    updateList('');
    super.onInit();
  }

  updateList(String val) async {
    notes = [];
    await FirestoreService().instance.get().then((snap) {
      snap.docs.forEach((doc) {
        if (doc.id.toLowerCase().contains(val.toLowerCase()))
          notes.add(Note(doc.get('title'), doc.get('content')));
      });
    });
    update();
  }
}
