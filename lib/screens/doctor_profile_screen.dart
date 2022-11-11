import 'package:flutter/material.dart';

import './booking_screen.dart';

class DoctorProfile extends StatelessWidget {
  static const routeName = '/doctor_profile';
  const DoctorProfile({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctorData =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    final doctorId = doctorData['id'];
    final doctorModel = doctorData['model'];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text(doctorModel.address),
              Text('${doctorModel.latitude}'),
              Text('${doctorModel.longitude}'),
              Text(doctorModel.city),
              Text('${doctorModel.sessionFee}'),
              Text('${doctorModel.sessionTime}'),
              Text('${doctorModel.yearsOfExperience}'),
              Text(doctorModel.name),
              Text(doctorId),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      doctorModel.picture,
                      fit: BoxFit.cover,
                      height: 160,
                      width: 120,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(doctorModel.name),
                      Text(doctorModel.specialty),
                    ],
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushNamed(BookAppointment.routeName,
                      arguments: doctorId as String);
                },
                child: const Text('Check Schedule'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
