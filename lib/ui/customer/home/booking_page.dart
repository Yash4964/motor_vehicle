import 'package:flutter/material.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   title: const Text(
      //     "My Profile",
      //     style: TextStyle(
      //       color: Colors.blueAccent,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(color: Colors.blueAccent),
      // ),
      body: Center(
        child: Text("booking"),
      ),
    );
  }
}
