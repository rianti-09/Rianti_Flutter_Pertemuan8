import 'package:flutter/material.dart';
import 'profile.dart';
import 'package:flutter_application_4/pertemuan/pertemuan5.dart';
import 'package:flutter_application_4/pertemuan/pertemuan6.dart';
import 'package:flutter_application_4/pertemuan/pertemuan7.dart';
import 'package:flutter_application_4/pertemuan/pertemuan8.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Pertemuan 5",
      "icon": Icons.book,
      "color": Colors.orange,
      "page": ListViewPage(),
    },
    {
      "title": "Pertemuan 6",
      "icon": Icons.book,
      "color": Colors.purple,
      "page": CheckboxPage(),
    },
    {
      "title": "Pertemuan 7",
      "icon": Icons.book,
      "color": Colors.orange,
      "page": RadiobuttonPage(),
    },
    {
      "title": "Pertemuan 8",
      "icon": Icons.book,
      "color": Colors.deepPurple,
      "page": AutocompleteSpinPage(),
    },
    {
      "title": "Profile",
      "icon": Icons.person,
      "color": Colors.red,
      "page": ProfilePage(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],

      appBar: AppBar(
        title: const Text("Dashboard"),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),

      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: menuItems.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
          ),
          itemBuilder: (context, index) {
            final item = menuItems[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => item['page']),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 5)],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: item['color'].withOpacity(0.2),
                      child: Icon(item['icon'], color: item['color'], size: 30),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      item['title'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
