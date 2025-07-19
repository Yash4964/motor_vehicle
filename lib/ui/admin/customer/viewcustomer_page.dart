import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller_api/customer_api_controller.dart';
// ignore: must_be_immutable
class CustomerProfilePage extends StatelessWidget {

  CustomerProfilePage({super.key});
   var arg = Get.arguments;
   final _formkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: Colors.white,
    appBar: AppBar(

    title:  Text('Customer Details',style: TextStyle(color: Colors.white),),
    backgroundColor: Colors.blue,
    iconTheme: IconThemeData(color: Colors.white),
    ),
      body: Form(
        child: SingleChildScrollView(
          child: Column(
            key: _formkey,
            children: [
              Padding(
                padding:  EdgeInsets.all(25),
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
                      arg[2],
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
                        "Email",
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
                        arg[1],
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
                        "phone",
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
                        arg[3],
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
      ),
    );
  }
}
