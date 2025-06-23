import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/ui/admin/home/dashboard_page.dart';
import 'package:motor_vehicle/ui/login_page.dart';
import 'package:motor_vehicle/ui/splash_page.dart';

void main() {
  runApp( MainApp());
}

class MainApp extends StatelessWidget {
   MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Motor Vehicle ',
      home: SplashPage(),
    );
  }
}

class Homepage extends StatelessWidget {
   Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(Dashboard_page());
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.blue,
                        child: Icon(Icons.admin_panel_settings,size: 50,color: Colors.amber,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Admin',style: TextStyle(fontSize:22)),
                    ),
                  ],
                ),
                SizedBox(width: 35,),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: (){
                        Get.to(LoginPage());
                      },
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.amber,
                        child: Icon(Icons.person,size: 50,color: Colors.blue,),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("User",style: TextStyle(fontSize:22),),
                    )
                  ],
                ),
              ],
          ),
        ),
      ),
    );
  }
}
