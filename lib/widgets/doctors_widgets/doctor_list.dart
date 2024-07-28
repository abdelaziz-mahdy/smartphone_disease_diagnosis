import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:smartphone_disease_diagnosis/screens/booking_screen.dart';

import '../../models/doctor_model.dart';
import '../../screens/doctor_profile_screen.dart';
import '../../state/doctors_state_management.dart';
import './doctor_tile.dart';

class DoctorsList extends ConsumerWidget {
  const DoctorsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchTerm = ref.watch(searchStringProvider);

    final doctorList = ref.watch(doctorsListProvider);

    final searchList = ref.watch(searchListProvider);

    return searchTerm == ''
        ? doctorList.when(
            data: (List<DocumentSnapshot<Object?>> value) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  DoctorModel doctorModel = DoctorModel.fromJson(
                      value[index].data() as Map<String, dynamic>);
                  return GestureDetector(
                    // onTap: () => Navigator.of(context)
                    //     .pushNamed(DoctorProfile.routeName, arguments: {
                    //   'id': value[index].id,
                    //   'model': doctorModel,
                    // }),
                    onTap: () => Navigator.of(context).pushNamed(
                        BookAppointment.routeName,
                        arguments: value[index].id),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: DoctorTile(
                        imageUrl: doctorModel.picture,
                        doctorName: doctorModel.name,
                        doctorSpecialty: doctorModel.specialty,
                        doctorRating: doctorModel.rating,
                        numOfRatings: doctorModel.numOfRatings,
                        doctorFee: doctorModel.sessionFee,
                      ),
                    ),
                  );
                },
              );
            },
            error: (value, stack) => const Center(
              child: Text("Something went wrong"),
            ),
            loading: () => const Center(
              child: Text('Loading...'),
            ),
          )
        : searchList.when(
            data: (List<DocumentSnapshot<Object?>> value) {
              return ListView.builder(
                itemCount: value.length,
                itemBuilder: (context, index) {
                  DoctorModel doctorModel = DoctorModel.fromJson(
                      value[index].data() as Map<String, dynamic>);
                  return GestureDetector(
                    onTap: () => Navigator.of(context)
                        .pushNamed(DoctorProfile.routeName, arguments: {
                      'id': value[index].id,
                      'model': doctorModel,
                    }),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                      ),
                      child: DoctorTile(
                        imageUrl: doctorModel.picture,
                        doctorName: doctorModel.name,
                        doctorSpecialty: doctorModel.specialty,
                        doctorRating: doctorModel.rating,
                        numOfRatings: doctorModel.numOfRatings,
                        doctorFee: doctorModel.sessionFee,
                      ),
                    ),
                  );
                },
              );
            },
            error: (value, stack) => const Center(
              child: Text("Something went wrong"),
            ),
            loading: () => const Center(
              child: Text('Loading...'),
            ),
          );
  }
}
