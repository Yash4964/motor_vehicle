import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/instance_manager.dart';
import 'package:motor_vehicle/main.dart';
import 'package:motor_vehicle/ui/customer/home/aboutus_page.dart';
import 'package:motor_vehicle/ui/login_page.dart';
import 'package:motor_vehicle/ui/registration_page.dart';

class Home_page extends StatelessWidget {
  Home_page({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Text(
          "Motor Driving School",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 25,
        shadowColor: Colors.black,
        toolbarHeight: 60,
      ),
      drawer: Container(
        width: 300,
        child: Drawer(
          child: ListView(
            children: [
              DrawerHeader(
                decoration: BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset(
                      "assets/images/logo.png",
                      height: 100,
                      width: 130,
                    ),
                    Text(
                      "Motor Driving School",
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  ListTile(
                    title: Text("Home"),
                    leading: Icon(Icons.home, size: 28),
                    onTap: () {
                      Get.to(Home_page());
                      Get.back();
                    },
                  ),
                  ListTile(
                    title: Text("About"),
                    leading: Icon(Icons.info),
                    onTap: () {
                      Get.to(AboutUs());
                    },
                  ),

                  ListTile(
                    title: Text("Vehicle "),
                    leading: Icon(Icons.directions_car),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Booking"),
                    leading: Icon(Icons.shopping_cart),
                    onTap: () {},
                  ),
                  ListTile(
                    title: Text("Login"),
                    leading: Icon(Icons.login),
                    onTap: () {
                      Get.to(LoginPage());
                    },
                  ),
                  ListTile(
                    title: Text("Registration"),
                    leading: Icon(Icons.app_registration),
                    onTap: () {
                      Get.to(RegistrationPage());
                    },
                  ),
                  ListTile(
                    title: Text("Profile"),
                    leading: Icon(Icons.person),
                    onTap: () {},
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
