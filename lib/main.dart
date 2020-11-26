import 'package:flutter/material.dart';
import 'package:brewcrew/screens/wrapper.dart';
import 'package:brewcrew/services/auth.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Person>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
      ),
    );
  }
}
