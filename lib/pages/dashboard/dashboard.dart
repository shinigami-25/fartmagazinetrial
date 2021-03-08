import 'package:fartmagazinetrial1/pages/dashboard/dashboardController.dart';
import 'package:fartmagazinetrial1/pages/note/addNote.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dashboard extends StatelessWidget {
  final _dashboardController = Get.put(DashboardController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
            _dashboardController.allTabsTitle[_dashboardController.tab.value])),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        tooltip: 'Add note',
        onPressed: () {
          Get.to(AddNote());
        },
      ),
      body: Obx(
          () => _dashboardController.allTabs[_dashboardController.tab.value]),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          onTap: (val) {
            _dashboardController.tab.value = val;
          },
          currentIndex: _dashboardController.tab.value,
          items: [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              label: 'Search',
              icon: Icon(Icons.search),
            ),
          ],
        ),
      ),
    );
  }
}
