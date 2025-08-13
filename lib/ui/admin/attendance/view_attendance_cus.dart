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
                //
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
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(
                        'assets/images/default_person.png',
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
