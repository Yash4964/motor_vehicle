import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
// ignore: must_be_immutable
class ViewVehicleDetails extends StatelessWidget {
  ViewVehicleDetails({super.key});
  var arg = Get.arguments;
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
      appBar: AppBar(

        title:  Text('Vehicle Details',style: TextStyle(color: Colors.white),),
        backgroundColor: Appcolor.primary,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(

        child: Column(

          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.lightBlue,
                    width: 2.5,
                  ),
                ),padding: EdgeInsets.all(2),
                child: ClipOval(
                  child: Image.asset(
                    arg[1],
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),


            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Vehicle Details",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Name",
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      arg[0],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      width: 320,
                      child: Divider(color: Colors.grey, thickness: 1.5),
                    ),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Car Number",
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      arg[2],
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),

                  Center(
                    child: Container(
                      width: 320,
                      child: Divider(color: Colors.grey, thickness: 1.5),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Age",
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "26",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 320,
                      child: Divider(color: Colors.grey, thickness: 1.5),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Gender",
                      style: TextStyle(
                        fontSize: 15,
                        color: const Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text(
                      "Male",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  Center(
                    child: Container(
                      width: 320,
                      child: Divider(color: Colors.grey, thickness: 1.5),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            // Container(
            //   width: 335,
            //   child: TextButton(
            //     onPressed: () {Get.to(EditProfilePage());},
            //     style: TextButton.styleFrom(
            //       backgroundColor: Colors.white,
            //       padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         side: BorderSide(color: Colors.black45),
            //       ),
            //     ),
            // child: Row(
            //   children: [
            //     Padding(
            //       padding: EdgeInsets.only(left: 30),
            //       child: Icon(Icons.edit, color: Colors.black),
            //     ),
            // Container(
            //   width: 335,
            //   child: TextButton(
            //     onPressed: () {},
            //     style: TextButton.styleFrom(
            //       backgroundColor: Colors.white,
            //       padding: EdgeInsets.symmetric(horizontal: 100, vertical: 10),
            //       shape: RoundedRectangleBorder(
            //         borderRadius: BorderRadius.circular(12),
            //         side: BorderSide(color: Colors.black45),
            //       ),
            //     ),
            //     child: Row(
            //       children: [
            //         Padding(
            //           padding: EdgeInsets.only(left: 30),
            //           child: Icon(Icons.edit, color: Colors.black),
            //         ),

            //         Padding(
            //           padding: EdgeInsets.only(left: 4),
            //           child: Text(
            //             "Edit Profile",
            //             style: TextStyle(color: Colors.black),
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),


          ],
        ),
      ),
    );
  }
}
