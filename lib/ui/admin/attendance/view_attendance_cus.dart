import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/controller/attendance_api_controller.dart';
import 'package:motor_vehicle/controller/booking_controller.dart';
import 'package:motor_vehicle/model/attendence_model.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class ViewAttendance extends StatelessWidget {
  List<AttendanceModel> attendenceList;

  ViewAttendance({super.key, required this.attendenceList});

  @override
  Widget build(BuildContext context) {
    if (attendenceList.isEmpty) {
      return const Center(child: Text('No Attendance yet'));
    }
    //decending order
    attendenceList.sort((a, b) => b.id.compareTo(a.id));

    return Scaffold(
      backgroundColor: Appcolor.background,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: attendenceList.length,
              itemBuilder: (BuildContext context, int index) {
                AttendanceModel attendance = attendenceList[index];
                DateTime dateTime = DateTime.parse(attendance.date.trim());
                final formattedDate = DateFormat('yyyy-MM-dd').format(dateTime);

                DateTime formateTime = DateTime.parse(attendance.time.trim());
                final formattedTime = DateFormat('hh mm a').format(formateTime);

                return Card(
                  color: Appcolor.container,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  elevation: 2,
                  child: ListTile(
                    leading: CircleAvatar(
                      radius: 27,
                      backgroundColor: Colors.grey[300],
                      child: ClipOval(
                        child: (attendance.image != null && attendance.image!.isNotEmpty)
                            ? Image.network(
                          attendance.image!,
                          width: 54,
                          height: 54,
                          fit: BoxFit.cover,
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return const Center(
                              child: SizedBox(
                                width: 24,
                                height: 24,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              ),
                            );
                          },
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(
                              "assets/images/default_person.png",
                              width: 54,
                              height: 54,
                              fit: BoxFit.cover,
                            );
                          },
                        )
                            : Image.asset(
                          "assets/images/default_person.png",
                          width: 54,
                          height: 54,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),



                    contentPadding: const EdgeInsets.all(12),
                    title: Text(
                      "Driver ID: 1",
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Text(
                      'Date: ${formattedDate}  |  Time: ${formattedTime}',
                      style: const TextStyle(color: Colors.black54),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
