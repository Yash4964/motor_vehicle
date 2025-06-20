import 'package:flutter/material.dart';
import 'package:motor_vehicle/widgets/container_table.dart';

class Dashboard_page extends StatelessWidget {
  const Dashboard_page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: Text('Dashboard',
            style: TextStyle(color: Colors.white),
        ),
        
      ),
      body: ListView(

        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),bottomRight: Radius.circular(30)
                ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: ListTile(
                title: Text('BL Kumawat',style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                subtitle: Text('Welcome Back',style: TextStyle(color: Colors.white,fontSize: 14,fontWeight: FontWeight.bold),),
                trailing: CircleAvatar(backgroundImage: AssetImage('assets/images/person.jpg'),radius: 30,),
              ),
            ),
          ),

          GridView.count(
            shrinkWrap: true,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
            padding: EdgeInsets.all(30),
            crossAxisCount: 2,
            children: [
              Container_table(
                tital: "Customer",
                u_icon: Icons.people,
                bg_color: Colors.lightBlue,
              ),
              Container_table(
                tital: "Booking",
                u_icon: Icons.bookmark_add,
                bg_color: Colors.amber,
              ),
              Container_table(
                tital: "Driver",
                u_icon: Icons.emoji_people,
                bg_color: Colors.purple,
              ),
              Container_table(
                tital: "Package",
                u_icon: Icons.paste_outlined,
                bg_color: Colors.lightGreen,
              ),
              Container_table(
                tital: "Vehicle",
                u_icon: Icons.drive_eta,
                bg_color: Color.fromARGB(255, 218, 67, 40),
              ),
              Container_table(
                tital: "Attendance",
                u_icon: Icons.add_task,
                bg_color: Color.fromARGB(255, 26, 180, 216),
              ),
            ],
            ),
        ],
      ),
    );
  }
}
