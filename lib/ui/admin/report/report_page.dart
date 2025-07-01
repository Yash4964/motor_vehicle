import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/payment/all_payment_details.dart';
import 'package:motor_vehicle/ui/admin/payment/pending_payment_list.dart';
import 'package:motor_vehicle/ui/admin/report/day_wise_page.dart';
import 'package:motor_vehicle/ui/admin/report/month_wise_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';

class ReportPage extends StatelessWidget {
  ReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(


        appBar: AppBar(
          foregroundColor: Colors.white,
          title:  Text("Report Dashboard",style:TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
          backgroundColor: Appcolor.primary,
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.green,
            labelStyle: TextStyle(fontWeight: FontWeight.bold,
              fontSize: 14,),
            labelPadding: EdgeInsets.only(top: 8),
            tabs: [
              Tab(text: "Day Wise"),
              Tab(text: "Month Wise"),
            ],
          ),
        ),
        body: Column(
          children: [
            Container(
              decoration:  BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
              ),

            ),
            Expanded(
              child: TabBarView(
                children: [
                  DayWisePage(),
                  MonthWisePage(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
