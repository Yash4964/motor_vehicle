import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class BookingPage extends StatelessWidget {
  BookingPage({super.key});
  var args = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF1F4F8),
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text("Your Booking Details"),
        backgroundColor: Appcolor.primary,
        elevation: 1,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),

            Center(
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                color: Colors.white,
                child: SizedBox(
                  width: 330,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
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
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Car Name",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              args[0],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height:10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Customer Name",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              args[1],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),


                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Package Name",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              args[2],
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Days",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              '${args[3]}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "KM",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              '${args[4]}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Price",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              '${args[5]}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Booking Date",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              '${args[6]}',
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              "Join Date",
                              style: TextStyle(
                                fontSize: 15,
                                color: Color.fromARGB(255, 129, 129, 129),
                              ),
                            ),
                            Text(
                              '${args[7]}',
                              style: const TextStyle(
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

            const SizedBox(height: 20),

            // // Attendance Details Card
            // Center(
            //   child: Card(
            //     elevation: 2,
            //     shape: RoundedRectangleBorder(
            //       borderRadius: BorderRadius.circular(16),
            //     ),
            //     color: Colors.white,
            //     child: SizedBox(
            //       width: 330,
            //       child: Padding(
            //         padding: const EdgeInsets.all(20.0),
            //         child: Column(
            //           children: [
            //             const Text(
            //               "Attendance Details",
            //               style: TextStyle(
            //                 fontSize: 18,
            //                 fontWeight: FontWeight.bold,
            //                 color: Colors.blueAccent,
            //               ),
            //             ),
            //             const SizedBox(height: 16),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: const [
            //                 Text(
            //                   "Date",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     color: Colors.grey,
            //                   ),
            //                 ),
            //                 Text(
            //                   "2025-06-30",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(height: 10),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: const [
            //                 Text(
            //                   "Time Slot",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     color: Colors.grey,
            //                   ),
            //                 ),
            //                 Text(
            //                   "10:00 AM - 11:00 AM",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(height: 10),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: const [
            //                 Text(
            //                   "Status",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     color: Colors.grey,
            //                   ),
            //                 ),
            //                 Text(
            //                   "Present",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //             const SizedBox(height: 10),
            //             Row(
            //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //               children: const [
            //                 Text(
            //                   "Driver Name",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     color: Colors.grey,
            //                   ),
            //                 ),
            //                 Text(
            //                   "Mr. Mahesh Yadav",
            //                   style: TextStyle(
            //                     fontSize: 15,
            //                     fontWeight: FontWeight.w600,
            //                   ),
            //                 ),
            //               ],
            //             ),
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
