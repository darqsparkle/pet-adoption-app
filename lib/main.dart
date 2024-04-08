import 'package:flutter/material.dart';
import 'homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isDark = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false, 
      themeMode: isDark ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData.light().copyWith(
        primaryColor: Colors.blue,
        appBarTheme: AppBarTheme(
          color:Colors.amber,
        ),
      ),
      darkTheme: ThemeData.dark().copyWith(
        primaryColor: Colors.indigo,
        appBarTheme: AppBarTheme(
          color: Colors.black,
        ),
      ),
      home: HomePage(
        toggleTheme: () {
          setState(() {
            isDark = !isDark; 
          });
        },
      ),
    );
  }
}
