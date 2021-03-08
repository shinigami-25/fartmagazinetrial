import 'package:fartmagazinetrial1/services/firestoreService.dart';
import 'package:fartmagazinetrial1/widgets/note.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  List<Widget> notes = [];
  @override
  void onInit() {
    updateNotes();
    super.onInit();
  }

  void updateNotes() async {
    notes = [];
    await FirestoreService().instance.get().then((doc) {
      doc.docs.forEach((doc) {
        notes.add(Note(doc.get('title'), doc.get('content')));
      });
    });
    update();
  }
}
