import 'package:fartmagazinetrial1/pages/home/homeController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class Home extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: StreamBuilder<QuerySnapshot>(
//         stream: FirestoreService().instance.snapshots(),
//         builder: (context, snapshot) {
//           List<Widget> notes = [];
//           snapshot.data.docs.forEach((doc) {
//             notes.add(Note(doc.get('title'), doc.get('content')));
//           });
//           return ListView.builder(
//             itemCount: notes.length,
//             itemBuilder: (context, index) => notes[index],
//           );
//         },
//       ),
//     );
//   }
// }

class Home extends StatelessWidget {
  // ignore: unused_field
  final _homeController = Get.put<HomeController>(HomeController());

  @override
  Widget build(BuildContext context) {
    return Container(
      child: GetBuilder<HomeController>(
        builder: (_homeController) {
          return ListView.builder(
            itemCount: _homeController.notes.length,
            itemBuilder: (context, index) => _homeController.notes[index],
          );
        },
      ),
    );
  }
}
