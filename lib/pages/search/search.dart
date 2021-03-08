import 'package:fartmagazinetrial1/pages/search/searchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

// class Search extends StatefulWidget {
//   @override
//   _SearchState createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   var _controller = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           Container(
//             padding: EdgeInsets.all(20),
//             width: MediaQuery.of(context).size.width,
//             height: 100,
//             child: TextField(
//               controller: _controller,
//               style: TextStyle(
//                 fontSize: 14,
//                 color: Colors.black,
//               ),
//               onChanged: (val) {
//                 setState(() {});
//               },
//               decoration: InputDecoration(
//                 suffixIcon: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white12,
//                     borderRadius: BorderRadius.all(Radius.circular(50)),
//                   ),
//                   child: IconButton(
//                     icon: Icon(Icons.search_outlined),
//                     onPressed: () {
//                       setState(() {});
//                     },
//                   ),
//                   padding: EdgeInsets.all(5),
//                 ),
//                 border: OutlineInputBorder(
//                   borderRadius: BorderRadius.all(Radius.circular(30)),
//                 ),
//               ),
//             ),
//           ),
//           Flexible(
//             child: StreamBuilder<QuerySnapshot>(
//               stream: FirestoreService().instance.snapshots(),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.active) {
//                   List<Widget> searchRes = [];
//                   snapshot.data.docs.forEach((doc) {
//                     if (doc.id
//                         .toLowerCase()
//                         .contains(_controller.text.toLowerCase()))
//                       searchRes.add(Note(doc.get('title'), doc.get('content')));
//                   });
//                   if (searchRes.length != 0) {
//                     return ListView(
//                       children: searchRes,
//                     );
//                   } else {
//                     return Text(
//                       'No results found',
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.black,
//                       ),
//                     );
//                   }
//                 } else {
//                   return Center(
//                     child: CircularProgressIndicator(
//                       backgroundColor: Colors.white,
//                     ),
//                   );
//                 }
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

class Search extends StatelessWidget {
  final _controller = TextEditingController();
  final _searchController = Get.put<SearchController>(SearchController());
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width,
            height: 100,
            child: TextField(
              controller: _controller,
              style: TextStyle(
                fontSize: 14,
                color: Colors.black,
              ),
              onChanged: (val) {
                _searchController.updateList(val);
              },
              decoration: InputDecoration(
                suffixIcon: Container(
                  decoration: BoxDecoration(
                    color: Colors.white12,
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                  ),
                  child: IconButton(
                    icon: Icon(Icons.search_outlined),
                    onPressed: () {
                      _searchController.updateList(_controller.text);
                    },
                  ),
                  padding: EdgeInsets.all(5),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
              ),
            ),
          ),
          Flexible(
            child: GetBuilder(
              init: _searchController,
              builder: (_searchController) {
                return ListView.builder(
                  itemCount: _searchController.notes.length,
                  itemBuilder: (_, index) => _searchController.notes[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
