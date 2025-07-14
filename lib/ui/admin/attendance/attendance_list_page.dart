import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/attendance/add_attendance_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import '../../../controller_api/attendance_api_controller.dart';

class AttendanceListPage extends StatelessWidget {
  AttendanceListPage({super.key});

  final attendenceConrollerApi a = Get.put(attendenceConrollerApi());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        title: const Text('Attendance List', style: TextStyle(color: Colors.white)),
        backgroundColor: Appcolor.primary,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() =>
          ListView.builder(
            itemCount: a.tolist.length,
            itemBuilder: (BuildContext context, int index) {
              final att = a.tolist[index];
              return Card(
                color: Appcolor.container,
                margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                elevation: 2,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(12),
                  leading: const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/images/person3.jpg'),
                  ),
                  title: Text(
                    att.bookingid,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Time : ',
                          style: TextStyle(
                            color: Colors.grey[800],
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text: '${att.time}\n',
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
                          text: att.date,
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
                          Get.to(() => AddAttendancePages(), arguments: {
                            "isEdit": true,
                            "bookingid": att.bookingid,
                            "date": att.date,
                            "time": att.time,
                            "id": att.id,
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
                                      Get.back();
                                      a.delapi(att.id);
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
          ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          a.clr();
          Get.to(() => AddAttendancePages());

        },
        child: const Icon(Icons.add, color: Colors.white),
        backgroundColor: Appcolor.primary,
      ),
    );
  }
}
