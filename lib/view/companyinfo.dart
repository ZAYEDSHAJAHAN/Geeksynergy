import 'package:flutter/material.dart';

class CompanyInfoScreen extends StatelessWidget {
  const CompanyInfoScreen({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
          child: Scaffold(
        appBar: AppBar(
          title: const Text("company info"),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            Text(
              'Geeksynergy Technologies Pvt Ltd',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Sanjayanagar, Bengaluru-56'),
            SizedBox(height: 10),
            Text('Phone: XXXXXXXXX09'),
            SizedBox(height: 10),
            Text('Email: XXXXXX@gmail.com'),
          ],
        ),
      ));
}
