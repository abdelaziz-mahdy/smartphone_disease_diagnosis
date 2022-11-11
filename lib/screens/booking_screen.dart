import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../models/booking_model.dart';
import '../state/doctors_state_management.dart';

class BookAppointment extends StatelessWidget {
  static const routeName = '/book_appointment';
  const BookAppointment({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final doctorId = ModalRoute.of(context)?.settings.arguments as String;
    final allDays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    var today = DateTime.now();
    var workDays = [];
    var workHours = [];
    var availableSlots = [];

    var chosenDay = today;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('Doctors')
              .doc(doctorId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return const Center(
                  child: Text('something went wrong!'),
                );
              } else if (snapshot.hasData) {
                workDays = (snapshot.data as DocumentSnapshot).get('workDays');
                workHours =
                    (snapshot.data as DocumentSnapshot).get('workHours');

                if ((workDays).contains(DateFormat.E().format(today)) ==
                    false) {
                  var availableDates = workDays
                      .map((e) => today.next(allDays.indexOf(e) + 1))
                      .toList();
                  today = availableDates
                      .reduce((min, e) => e.isBefore(min) ? e : min);

                  chosenDay = today;
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CalendarTimeline(
                      initialDate: today,
                      firstDate: DateTime.now(),
                      lastDate: DateTime.now().add(const Duration(days: 365)),
                      onDateSelected: (date) => chosenDay = date,
                      leftMargin: 20,
                      monthColor: Colors.blueGrey,
                      dayColor: Colors.teal[200],
                      activeDayColor: Colors.white,
                      activeBackgroundDayColor: const Color.fromARGB(255, 127, 164, 248),
                      dotsColor: const Color(0xFF333A47),
                      selectableDayPredicate: (date) =>
                          workDays.contains(DateFormat.E().format(date)),
                      locale: 'en_ISO',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const SizedBox(
                      width: double.infinity,
                      child: Text(
                        'Available Slots',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: FirebaseFirestore.instance
                          .collection('Bookings')
                          .snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const SizedBox(
                            height: 430,
                            child: Center(
                              child: Text('Loading...'),
                            ),
                          );
                        } else if (snapshot.hasError) {
                          return const Center(
                            child: Text('something went wrong!'),
                          );
                        } else if (snapshot.hasData) {
                          //print('chosen date $chosenDay');

                          var querySnapshot = snapshot.data;

                          var docSnapshots = querySnapshot!.docs;
                          availableSlots = [];
                          var bookedSlots = [];

                          for (var i in docSnapshots) {
                            var bookingTime = i.get('timestamp').toDate();

                            //print('booked appointment $bookingTime');

                            if ((bookingTime as DateTime)
                                .isSameDate(chosenDay)) {
                              String formattedTime =
                                  DateFormat.Hm().format(bookingTime);

                              bookedSlots.add(formattedTime);
                            }
                          }

                          availableSlots = workHours
                              .where((e) => !bookedSlots.contains(e))
                              .toList();

                          // print('workHours ${workHours.toString()}');

                          // print('booked ${bookedSlots.toString()}');
                          // print('available ${availableSlots.toString()}');

                          return Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: SizedBox(
                              height: 420,
                              child: GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3,
                                  childAspectRatio: 2,
                                  mainAxisSpacing: 15,
                                  crossAxisSpacing: 15,
                                ),
                                itemBuilder: (ctx, index) {
                                  return Consumer(
                                    builder: (context, ref, child) =>
                                        OutlinedButton(
                                      onPressed: () {
                                        ref
                                            .read(selectedTimeProvider.notifier)
                                            .state = index;
                                      },
                                      style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                            RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15.0),
                                          ),
                                        ),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                          ref.watch(selectedTimeProvider) ==
                                                  index
                                              ? const Color.fromARGB(255, 127, 164, 248)
                                              : Colors.white,
                                        ),
                                        foregroundColor:
                                            MaterialStateProperty.all(
                                          ref.watch(selectedTimeProvider) ==
                                                  index
                                              ? Colors.white
                                              : const Color.fromARGB(255, 127, 164, 248),
                                        ),
                                      ),
                                      child: Text(
                                        availableSlots[index],
                                      ),
                                    ),
                                  );
                                },
                                itemCount: availableSlots.length,
                              ),
                            ),
                          );
                        } else {
                          return const Center(
                              child: Text('Something went wrong'));
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Consumer(
                        builder: (context, ref, child) => ElevatedButton(
                          onPressed: () async {
                            final selectedTime =
                                ref.watch(selectedTimeProvider);

                            if (selectedTime == null) {
                              return;
                            }

                            final userId =
                                FirebaseAuth.instance.currentUser!.uid;

                            final time =
                                (availableSlots[selectedTime] as String)
                                    .split(':');

                            final appointmentDate = DateTime(
                              chosenDay.year,
                              chosenDay.month,
                              chosenDay.day,
                              int.parse(time[0]),
                              int.parse(time[1]),
                              0,
                              0,
                              0,
                            );

                            final appointment = BookingModel(
                              timestamp: appointmentDate,
                              doctorId: doctorId,
                              userId: userId,
                            );
                            await FirebaseFirestore.instance
                                .collection('Bookings')
                                .add(appointment.toJson())
                                .then((value) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      content: SizedBox(
                                    height: 220,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: const [
                                        IconButton(
                                          onPressed: null,
                                          icon: Icon(
                                            Icons.check_circle_sharp,
                                            size: 60,
                                            color: Colors.blue,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: 20,
                                            horizontal: 15,
                                          ),
                                          child: Text(
                                            'Your Booking is Confirmed!',
                                            style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w900),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ));
                                },
                              );
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(const Color.fromARGB(255, 127, 164, 248)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15.0),
                              ),
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Text(
                              'Book Appointment',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }
            }
            return const Center(
              child: Text('Loading...'),
            );
          },
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    if (day == weekday) {
      return add(const Duration(days: 7));
    } else {
      return add(
        Duration(
          days: (day - weekday) % DateTime.daysPerWeek,
        ),
      );
    }
  }
}
