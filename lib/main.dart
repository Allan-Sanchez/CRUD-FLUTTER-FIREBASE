import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// theme 
import 'package:crud_firebase_flutter/app_theme.dart';
// routes
import 'package:crud_firebase_flutter/screens/home_page.dart';
import 'package:crud_firebase_flutter/screens/new.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      theme: themeData,
      initialRoute: "/",
      routes: {
        '/': (BuildContext context) => const HomePage(),
        '/new': (BuildContext context) => const NewData(),
      },
    );
  }
}
