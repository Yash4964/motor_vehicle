import 'package:flutter/material.dart';
import 'package:motor_vehicle/widgets/text_field_widget.dart';

class AddcustomerPage extends StatelessWidget {
  AddcustomerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Booking Details', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.blue,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Stack(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/person.jpg'),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Colors.lightBlue,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.white, size: 22),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Center(
              child: Text(
                'Customer Details',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
            ),
            const SizedBox(height: 20),

            labels("Name"),
            TextFieldWidget(
              hint: 'Name',
              textInputType: TextInputType.name,
            ),

            labels("Email"),
            TextFieldWidget(
              hint: "ex: jon.smith@gmail.com",
              textInputType: TextInputType.emailAddress,
            ),

            labels("New Password"),
            TextFieldWidget(
              hint: "New password",
              obscureText: true,
            ),

            labels("Confirm Password"),
            TextFieldWidget(
              hint: "Confirm password",
              obscureText: true,
            ),

            labels("Mobile"),
            TextFieldWidget(
              hint: "+91 9632587415",
              textInputType: TextInputType.phone,
            ),

            labels("Age"),
            TextFieldWidget(
              hint: "Age must be 18+",
              textInputType: TextInputType.number,
            ),

            labels("Address"),
            TextFieldWidget(
              hint: "Address",
              textInputType: TextInputType.text,
            ),

            const SizedBox(height: 20),
            InkWell(
              onTap: () {

              },
              child: Container(
                width: double.infinity,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: const Text(
                  "Submit",
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget labels(String txt) {
    return Padding(
      padding: const EdgeInsets.only(top: 12, bottom: 6, left: 5),
      child: Text(txt, style: const TextStyle(fontSize: 16)),
    );
  }
}
