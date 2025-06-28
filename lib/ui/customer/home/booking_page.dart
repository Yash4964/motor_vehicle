import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key});
  var args = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F4F8),
      appBar: AppBar(
        foregroundColor:Colors.white,
        title: Text(" Your Booking details"),

        backgroundColor: Appcolor.primary,
        elevation: 1,

        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Padding(padding: EdgeInsets.only(left: 20, bottom: 10, top: 30)),
            // Text(
            //   "Your Booking Details",
            //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            // ),

            Padding(
              padding: EdgeInsets.only(top: 20.0),
              child: Center(
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),

                  color: Colors.white,
                  child: SizedBox(
                    width: 330,
                    height: 430,
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: Column(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              "assets/images/swift.jpg",
                              width: double.infinity,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          SizedBox(height: 20),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Customer Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                              Text(
                                args[0],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Package Name",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                              Text(
                                args[1],
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Days",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                              Text(
                                '${args[2]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "KM",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                              Text(
                                '${args[3]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Price",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                              Text(
                                '${args[4]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Booking Date",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                              Text(
                                '${args[5]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Join Date",
                                style: TextStyle(
                                  fontSize: 15,
                                  color: Color.fromARGB(255, 129, 129, 129),
                                ),
                              ),
                              Text(
                                '${args[6]}',
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
