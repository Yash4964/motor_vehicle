import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class ProfilePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:  Color(0xFFF1F4F8),
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 1,
      //   title: const Text(
      //     "My Profile",
      //     style: TextStyle(
      //       color: Colors.blueAccent,
      //       fontWeight: FontWeight.bold,
      //     ),
      //   ),
      //   centerTitle: true,
      //   iconTheme: const IconThemeData(color: Colors.blueAccent),
      // ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:40.0,left: 25,right: 25,bottom: 30),
              child: Container(
                height: 170,
                width: 600,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        padding: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color:  Color.fromARGB(255, 139, 136, 136),
                            width: 2,
                          ),
                        ),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundImage: AssetImage(
                            "assets/images/person.jpg",
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40, left: 10),
                            child: Text(
                              "John Doe",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.only(left: 10),
                                child: Icon(Icons.mail_rounded, size: 20),
                              ),

                              Padding(
                                padding: EdgeInsets.only(left: 4),
                                child: Text(
                                  " johndoe@gmail.com",
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20, bottom: 10),
                  child: Text(
                    "Personal Details",
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
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "phone",
                      style: TextStyle(
                        fontSize: 15,
                        color:  Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "+91 9925973355",
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
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "License No",
                      style: TextStyle(
                        fontSize: 15,
                        color:  Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "DL-1234-567890",
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
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "Course",
                      style: TextStyle(
                        fontSize: 15,
                        color:  Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      "4-Wheeler Advanced",
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
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left:20.0,right: 20),
                  child: Container(
                        height: 40,
                      
                        width: 320,
                        child: ElevatedButton(
                          onPressed: () {
                            
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 65, 33, 243),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(7),
                            ),
                          ),
                          child: Text(
                            "Log Out",
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                          
                        ),
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
