import 'package:fartmagazinetrial1/shared.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'pages/dashboard/dashboard.dart';
import 'services/authenticationService.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future app = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      home: FutureBuilder(
        future: app,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return FutureBuilder(
              future: AuthenticationService().signInWithGoogle(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done &&
                    snapshot.data != null) {
                  curUser = snapshot.data.user;
                  return Dashboard();
                }
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
