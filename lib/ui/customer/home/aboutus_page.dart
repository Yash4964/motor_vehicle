import 'package:flutter/material.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:widget_zoom/widget_zoom.dart';

class Aboutus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: WidgetZoom(
                      heroAnimationTag: 'tag',
                      zoomWidget: Image.asset(
                        'assets/images/shop.jpg',
                        height: 200,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: WidgetZoom(
                       heroAnimationTag: 'tag',
                      zoomWidget: Image.asset(
                        'assets/images/shop1.jpg',
                        height: 200,
                        width: 150,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  
                ],
              ),
            ),

            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:Appcolor.container,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Contact-us',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Name :"),
                        SizedBox(width: 10),
                        Text("Bhavin Prajapati"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text("Time :"),
                        SizedBox(width: 10),
                        Text("Mon-Sat"),
                        SizedBox(width: 10),
                        Text("(7:00 AM - 7:00 PM)"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(width: 20),
                        Text("9038475936"),
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Icon(Icons.home),
                        SizedBox(width: 20),
                        Text("Bhavani park"),
                      ],
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Why Choose Us?',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 12),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Knowing how to drive a car is no longer a luxury, it’s a necessity!',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'We teach driving on both theoretical and practical fronts with the help of our',
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Training Experts and cutting-edge Driving Simulators.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/Innovative.png', height: 150),
                    SizedBox(height: 5),
                    Text(
                      'New Age-Tech Enabled',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Our innovative approach makes the learning experience a lot more engaging! Learn the art of driving at Maruti Suzuki Driving School with innovative teaching methods, real-time knowledge, and practical exposure.',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/Expertise.png', height: 150),
                    SizedBox(height: 5),
                    Text(
                      'Expertise',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'You cannot be ignorant on the road, as you have to care about everyone aboard! Inherit the DNA of being a responsible and caring driver with the world-class driving training of Maruti Suzuki Driving School.',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Image.asset('assets/images/qualified.png', height: 150),
                    SizedBox(height: 5),
                    Text(
                      'Caring',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'That is why we have assembled a vast team of expert trainers to help you learn the right way! Trained rigorously, our expert trainers are equipped to deliver world-class driving training.',
                      style: TextStyle(fontSize: 15),
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
