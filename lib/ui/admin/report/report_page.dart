import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:motor_vehicle/ui/admin/report/days_page.dart';
import 'package:motor_vehicle/ui/admin/report/months_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import '../../../controller/report_api_controller.dart';

class ReportPage extends StatefulWidget {
  const ReportPage({super.key});

  @override
  State<ReportPage> createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final reportControllerDays = Get.put(ReportController(), tag: 'days');
  final reportControllerMonths = Get.put(ReportController(), tag: 'months');

  @override
  void initState() {
    super.initState();

    _tabController = TabController(length: 2, vsync: this);

    // Initial fetch
    final today = DateTime.now();
    final dayFormatted = DateFormat('dd-MM-yyyy').format(today);
    reportControllerDays.selectedDate.value = today;
    reportControllerDays.dateController.text = dayFormatted;
    reportControllerDays.fetchByDate(dayFormatted);

    final monthFormatted = DateFormat('MM-yyyy').format(today);
    reportControllerMonths.selectedDate.value = today;
    reportControllerMonths.dateController.text = monthFormatted;
    reportControllerMonths.fetchByDate(monthFormatted);

    // Reload data on tab change
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) return;

      if (_tabController.index == 0) {
        // Day-wise tab: fetch again
        final today = reportControllerDays.selectedDate.value;
        final formatted = DateFormat('dd-MM-yyyy').format(today);
        reportControllerDays.fetchByDate(formatted);
      } else if (_tabController.index == 1) {
        // Month-wise tab: fetch again
        final today = reportControllerMonths.selectedDate.value;
        final formatted = DateFormat('MM-yyyy').format(today);
        reportControllerMonths.fetchByDate(formatted);
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          "Report Dashboard",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Appcolor.primary,
        bottom: TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicatorColor: Colors.green,
          labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          labelPadding: const EdgeInsets.only(top: 8),
          tabs: const [
            Tab(text: "Day Wise"),
            Tab(text: "Month Wise"),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          DaysPage(),
          MonthsPage(),
        ],
      ),
    );
  }
}
