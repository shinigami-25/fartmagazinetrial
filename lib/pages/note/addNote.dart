import 'package:fartmagazinetrial1/pages/note/noteController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AddNote extends StatelessWidget {
  final contentController = TextEditingController();
  final titleController = TextEditingController();
  final _addNoteController = Get.put<NoteController>(NoteController());
  String path = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: Center(
                  child: Icon(Icons.camera),
                ),
              ),
              onTap: () async {
                var res = await _addNoteController.pickFile();
                path = res.files.single.path;
              },
            ),
            SizedBox(
              height: 15,
            ),
            Text(path),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextFormField(
              maxLines: 15,
              controller: contentController,
              decoration: InputDecoration(
                labelText: 'Note',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(15)),
                ),
              ),
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            FlatButton(
              textColor: Colors.white,
              color: Colors.black,
              child: Text('Add Note'),
              onPressed: () async {
                await _addNoteController.addNoteCallback(
                  this.titleController.text,
                  this.contentController.text,
                  this.path,
                );
                // await FirestoreService().addNote(
                //     this.titleController.text, this.contentController.text,
                //     path:
                //         'users/${curUser.email}/${this.titleController.text}.jpg');
                // await StorageService()
                //     .addPic(this.titleController.text, this.path);
                // Get.find<HomeController>().updateNotes();
                // Get.back();
              },
            ),
          ],
        ),
      ),
    );
  }
}
