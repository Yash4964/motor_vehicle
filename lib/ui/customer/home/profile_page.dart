import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/utils.dart';
import 'package:get_storage/get_storage.dart';
import 'package:motor_vehicle/ui/login_page.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/customer_model.dart';
import '../../../model/response_model.dart';

class ProfilePage extends StatelessWidget {
  final Uri _url = Uri.parse(
    'https://www.youtube.com/watch?v=JYLEyMvj6sE&list=RDf23e6nfVQiI&index=4',
  );
  GetStorage getStorage =GetStorage();

  @override
  Widget build(BuildContext context)  {
    CustomerModel customerdata = CustomerModel.fromJson(getStorage.read('user'));

    return Scaffold(
      backgroundColor: Appcolor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: 20.0,
                left: 25,
                right: 25,
                bottom: 10,
              ),
              child: Container(
                height: 130,
                width: 640,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 2),
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
                            color: Color.fromARGB(255, 139, 136, 136),
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
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(top: 40, left: 10),
                            child: Text(
                              //CustomerModel.fromJson(jsonDecode(getStorage.read('user'))).name.toString(),
                              customerdata.name,
                              //(CustomerModel.fromJson(getStorage.read('user')).name.toString()),
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
                                  customerdata.email,
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
                        color: Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      customerdata.mobile_no,
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
                      "Address",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      customerdata.address,
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
                      "Pincode",
                      style: TextStyle(
                        fontSize: 15,
                        color: Color.fromARGB(255, 129, 129, 129),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: Text(
                      customerdata.pincode,
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
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20),
                  child: Container(
                    height: 40,
                    width: 320,

                    child: ElevatedButton(
                      onPressed: () async {
                        final SharedPreferences prefs = await SharedPreferences.getInstance();
                        await prefs.setBool('isLogin', false);
                        Get.offAll(LoginPage());
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Appcolor.primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),

                      child: Text(
                        "Log Out",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 20.0, right: 20, top: 20),
                  child: Container(
                    height: 40,
                    width: 320,
                    child: ElevatedButton(
                      onPressed: _launchUrl,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.lightGreen,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                      child: Text(
                        "Terms & Conditions",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
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

  Future<void> _launchUrl() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not Launch $_url');
    }
  }
}
