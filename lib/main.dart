import 'package:flutter/material.dart';
import 'package:flutter_application_4/page/dashboard.dart';
import 'package:flutter_application_4/page/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  final List<Widget> _pages = [DashboardPage(), ProfilePage()];

  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
        body: _pages[currentPage],
        bottomNavigationBar: SalomonBottomBar(
          currentIndex: currentPage,
          onTap: (i) => setState(() => currentPage = i),
          items: [
            //Beranda
            SalomonBottomBarItem(
              icon: Icon(Icons.home),
              title: Text('Beranda'),
              selectedColor: Colors.blue,
            ),

            //Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text('Profile'),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}
