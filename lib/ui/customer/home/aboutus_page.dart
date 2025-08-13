import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:motor_vehicle/controller/about_api_controller.dart';
import 'package:motor_vehicle/widgets/appcolor_page.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:widget_zoom/widget_zoom.dart';


class Aboutus extends StatelessWidget {
  AboutApiController controller = Get.put(AboutApiController());

  @override
  Widget build(BuildContext context) {
    //controller.aboutget();
    return Scaffold(
      backgroundColor: Appcolor.background,
      body: SafeArea(
        child: Obx(() {
          if (controller.loader.value) {
            return Center(child: CircularProgressIndicator());
          }

          if (controller.aboutModel == null) {
            return Center(child: Text("No data available"));
          }

          final about = controller.aboutModel?.value;
          final Uri tel1 = Uri.parse('tel:${about?.aboutPhoneNo1}');
          final Uri tel2 = Uri.parse('tel:${about?.aboutPhoneNo2}');

          return SingleChildScrollView(
            padding: EdgeInsets.only(bottom: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: WidgetZoom(
                            heroAnimationTag: 'tag1',
                            zoomWidget: Image.network(
                                "${about?.aboutImage1}" ?? '',
                              height: 200,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 16),
                      Expanded(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: WidgetZoom(
                            heroAnimationTag: 'tag2',
                            zoomWidget: Image.network(
                              "${about?.aboutImage2}",
                              height: 200,
                              fit: BoxFit.cover,
                            ),
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
                      color: Appcolor.container,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Text(
                            'Contact Us',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Divider(thickness: 2),
                        SizedBox(height: 16),
                        // First contact
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.person, size: 20),
                            SizedBox(width: 8),
                            Expanded(child: Text("Harshadsinh Zala")),
                            InkWell(
                              onTap: () => _call(tel1),
                              child: Icon(Icons.phone, size: 25, color: Colors.green),
                            ),
                            SizedBox(width: 8),
                            Flexible(child: Text("${about?.aboutPhoneNo1}")),
                          ],
                        ),
                        SizedBox(height: 18),
                        // Second contact
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.person, size: 20),
                            SizedBox(width: 8),
                            Expanded(child: Text("Vipulsinh Zala")),
                            InkWell(
                              onTap: () => _call(tel2),
                              child: Icon(Icons.phone, size: 25, color: Colors.green),
                            ),
                            SizedBox(width: 8),
                            Flexible(child: Text("${about?.aboutPhoneNo2}")),
                          ],
                        ),
                        SizedBox(height: 16),
                        // Opening hours
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.access_time, size: 20),
                            SizedBox(width: 8),
                            Flexible(
                              child: RichText(
                                text: TextSpan(
                                  style: DefaultTextStyle.of(context).style,
                                  children: [
                                    TextSpan(text: "Mon-Sat "),
                                    TextSpan(
                                      text: "(${about?.openingHours})",
                                      style: TextStyle(fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(Icons.home, size: 20),
                            SizedBox(width: 8),
                            Expanded(child: Text("${about?.address}")),
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
          );
        }),
      ),
    );

  }

  Future<void> _call(Uri uri) async {
    if (!await launchUrl(uri)) {
      throw Exception('Invalid phone number');
    }
  }
}
