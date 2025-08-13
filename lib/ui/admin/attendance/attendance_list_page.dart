import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import '../../../controller/attendance_api_controller.dart';

class AttendanceListPage extends StatelessWidget {
  AttendanceListPage({super.key});

  final AttendenceConrollerApi a = Get.put(AttendenceConrollerApi());

  @override
  Widget build(BuildContext context) {
    a.attendanceget();
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: const Text('Attendance List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(()
      {
        if(a.attendList.isEmpty)
          {
            return Center(child: CircularProgressIndicator());
          }
        else
          {
            return ListView.builder(
              itemCount: a.attendList.length,
              itemBuilder: (BuildContext context, int index) {
                final att = a.attendList[index];
                DateTime dateTime = DateTime.parse(att.date);
                DateTime time = DateTime.parse(att.time);
                final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);
                final timeformate = DateFormat('hh:mm').format(time);
                return Card(
                  color: Appcolor.container,
                  margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12),
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: att.image != null
                          ? NetworkImage("${att.image}")
                          : AssetImage('assets/images/person3.jpg') as ImageProvider,
                    ),

                    title: Text(
                      "Booking id: ${att.booking_id}",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Driver Id : ',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: '${att.driver_id}\n',
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          TextSpan(
                            text: 'Date : ',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "${formattedDate}\n",
                            style: TextStyle(color: Colors.grey[700]),
                          ),
                          TextSpan(
                            text: 'Time : ',
                            style: TextStyle(
                              color: Colors.grey[800],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          TextSpan(
                            text: "${timeformate}\n",
                            style: TextStyle(color: Colors.grey[700]),
                          ),

                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.green),
                          onPressed: () {
                            a.clear();
                            Get.to(() => AddAttendancePages(), arguments: {
                              "isEdit": true,
                              "id": att.id,
                              "Time": timeformate,
                              "date": formattedDate,
                              "booking_id": att.booking_id.toString(),
                              "driver_id": att.driver_id.toString()
                            });
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: const Text("Delete"),
                                  content: const Text(
                                    "Are you sure you want to delete?",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                         a.attendancedelete(att.id);
                                        Get.back();
                                      },
                                      child: const Text("OK"),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }
      }

      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
            a.clear();
            Get.to(() => AddAttendancePages());

        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
