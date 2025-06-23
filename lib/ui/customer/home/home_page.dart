import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/customer/home/aboutus_page.dart';
import 'package:motor_vehicle/ui/customer/home/booking_page.dart';
import 'package:motor_vehicle/ui/customer/home/profile_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text(" Home ", style: TextStyle(fontSize: 24))),
    Aboutus(),
    Center(child: Text(" Vehicle ", style: TextStyle(fontSize: 24))),
    //Center(child: Text(" Booking Page", style: TextStyle(fontSize: 24))),
    BookingPage(),
    ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,

      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Container(
          height: 250,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(24),
              bottomRight: Radius.circular(24),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      child: Image.asset(
                        'assets/images/logo.png',
                        width: 60,
                        height: 60,
                      ),
                    ),
                  ),

                  const SizedBox(width: 8),
                  const Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(top: 5.0, left: 25.0),
                      child: Text(
                        'Motor Driving School',
                        style: TextStyle(
                          color: Color.fromARGB(255, 49, 83, 146),
                          fontSize: 21,
                          fontWeight: FontWeight.bold,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.info), label: "About"),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: "Vehicle",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: "Booking",
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}
