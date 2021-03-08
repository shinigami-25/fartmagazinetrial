import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'editNoteController.dart';


// ignore: must_be_immutable
class EditNote extends StatelessWidget {
  final contentController = TextEditingController();
  final titleController = TextEditingController();
  EditNoteController _noteController;
  EditNote(this.title, this.content) {
    _noteController = Get.put<EditNoteController>(EditNoteController(title));
  }
  final title, content;
  String path;
  

  @override
  Widget build(BuildContext context) {
    titleController.text = this.title;
    contentController.text = this.content;
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Note'),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GetBuilder(
              init: _noteController,
              builder: (_noteController) => GestureDetector(
                child: Container(
                  height: 100,
                  width: 100,
                  decoration: BoxDecoration(
                    color: Colors.black12,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    image: DecorationImage(
                      image: NetworkImage(_noteController.link),
                    ),
                  ),
                  child: Icon(Icons.camera_enhance_outlined),
                ),
                onTap: () async {
                  var res = await Get.find<EditNoteController>().pickFile();
                  path = res.files.single.path;
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: titleController,
              enabled: false,
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
              child: Text('Edit Note'),
              onPressed: () async {
                await Get.find<EditNoteController>().editNoteCallback(
                    this.titleController.text,
                    this.contentController.text,
                    this.path);
              },
            ),
          ],
        ),
      ),
    );
  }
}
