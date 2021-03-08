import 'package:fartmagazinetrial1/services/storageService.dart';
import 'package:flutter/material.dart';

class ShowNoteLinks extends StatelessWidget {
  ShowNoteLinks(this.title, this.content, this.link);
  final title, content, link;
  @override
  Widget build(BuildContext context) {
    debugPrint(link);
    return Scaffold(
      appBar: AppBar(
        title: Text('Note'),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            FutureBuilder(
              future: StorageService().picFutureFromLink(this.link),
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
