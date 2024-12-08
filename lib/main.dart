import 'package:flutter/material.dart';
import 'package:notes_exp/add_note.dart';
import 'package:notes_exp/db_provider.dart';
import 'package:notes_exp/detail_page.dart';
import 'package:notes_exp/home_page.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

void main() {
  runApp (ChangeNotifierProvider(create: (context)=>DbProvider(),
  child: MyApp(),));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

