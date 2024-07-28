import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../resources/doctor_firestore_methods.dart';
import '../models/search_filters_model.dart';

final searchStringProvider = StateProvider.autoDispose<String>((ref) => '');

final filtersProvider =
    StateProvider.autoDispose<FiltersModel>((ref) => FiltersModel());

final appointmentDayProvider =
    StateProvider.autoDispose<DateTime>((ref) => DateTime.now());

final selectedTimeProvider = StateProvider.autoDispose<int?>((ref) => null);

final bookingsProvider = FutureProvider.autoDispose<
    List<QueryDocumentSnapshot<Map<String, dynamic>>>>((ref) async {
  return await FirebaseFirestore.instance
      .collection('Bookings')
      .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
      .get()
      .then((value) => value.docs);
});

final doctorsListProvider =
    FutureProvider.autoDispose<List<DocumentSnapshot>>((ref) async {
  final filters = ref.watch(filtersProvider);

  final finalList = await getFilteredDoctorsList(filters);

  return finalList;
});

final searchListProvider =
    StateProvider.autoDispose<AsyncValue<List<DocumentSnapshot<Object?>>>>(
        (ref) {
  final doctorsList = ref.watch(doctorsListProvider);
  final searchString = ref.watch(searchStringProvider);

  return doctorsList.whenData((value) => value
      .where((element) =>
          (element.get('name') as String).toLowerCase().contains(searchString))
      .toList());
});

final apointmentListProvider = FutureProvider.autoDispose<List>((ref) async {
  final chosenDay = ref.watch(appointmentDayProvider);
  final userBookings = ref.watch(bookingsProvider);

  var appointmentSlots = [];

  return userBookings.when(
    data: (value) async {
      for (var i in value) {
        await FirebaseFirestore.instance
            .collection('Doctors')
            .doc(i.get('doctorId'))
            .get()
            .then((value) {
          var bookingTime = i.get('timestamp').toDate();
          if ((bookingTime as DateTime).isSameDate(chosenDay)) {
            String sessionStart = DateFormat.Hm().format(bookingTime);
            DateTime endTime =
                bookingTime.add(Duration(minutes: value.get('sessionTime')));
            String sessionEnd = DateFormat.Hm().format(endTime);

            appointmentSlots.add({
              'image': value.get('picture'),
              'name': value.get('name'),
              'specialty': value.get('specialty'),
              'date': DateFormat.yMMMd().format(bookingTime),
              'fee': value.get('sessionFee'),
              'start': sessionStart,
              'end': sessionEnd,
            });
          }
        });
      }
      return appointmentSlots;
    },
    error: (val, stack) => [],
    loading: () => [],
  );
});

extension DateOnlyCompare on DateTime {
  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}
