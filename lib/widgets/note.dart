import 'package:fartmagazinetrial1/pages/editNote/editNote.dart';
import 'package:fartmagazinetrial1/services/dynamicLinkService.dart';
import 'package:fartmagazinetrial1/services/firestoreService.dart';
import 'package:fartmagazinetrial1/services/shareService.dart';
import 'package:fartmagazinetrial1/services/storageService.dart';
import 'package:fartmagazinetrial1/shared.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Note extends StatefulWidget {
  Note(this.title, this.content);
  final title, content;
  @override
  _NoteState createState() => _NoteState();
}

class _NoteState extends State<Note> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      child: GestureDetector(
        child: Container(
          padding: EdgeInsets.all(15),
          height: 100,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(widget.title),
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () =>
                    Get.to(() => EditNote(widget.title, widget.content)),
              ),
            ],
          ),
        ),
        onTap: () => Get.to(() => ShowNote(widget.title, widget.content)),
      ),
      onDismissed: (dir) async {
        await FirestoreService().removeNote(widget.title);
        await StorageService().removePic(widget.title);
      },
    );
  }
}

class ShowNote extends StatelessWidget {
  ShowNote(this.title, this.content);
  final title, content;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
        actions: [
          IconButton(
            icon: Icon(Icons.share),
            onPressed: () async {
              Uri link = await DynamicLinkService().createDynamicLinks(
                  this.title,
                  this.content,
                  'users/${curUser.email}/${this.title}.jpg');
              ShareService().share(link.toString());
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: StorageService().picFuture(this.title),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return Container(
                    height: 200,
                    width: MediaQuery.of(context).size.width - 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(snapshot.data),
                      ),
                    ),
                  );
                }
                return Container();
              },
            ),
            Text(
              this.title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Text(
              this.content,
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
