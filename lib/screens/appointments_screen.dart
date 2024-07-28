import 'package:flutter/material.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../state/doctors_state_management.dart';
import '../widgets/doctors_widgets/appointment_card.dart';

class AppointmentsScreen extends StatelessWidget {
  static const routeName = '/show_appointments';
  const AppointmentsScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Consumer(
                builder: (context, ref, child) => CalendarTimeline(
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now().subtract(const Duration(days: 30)),
                  lastDate: DateTime.now().add(const Duration(days: 365)),
                  onDateSelected: (date) =>
                      ref.read(appointmentDayProvider.notifier).state = date,
                  leftMargin: 20,
                  monthColor: Colors.blueGrey,
                  dayColor: Colors.teal[200],
                  activeDayColor: Colors.white,
                  activeBackgroundDayColor:
                      const Color.fromARGB(255, 127, 164, 248),
                  dotsColor: const Color(0xFF333A47),
                  locale: 'en_ISO',
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Consumer(
                  builder: (context, ref, child) {
                    final appointmentsList = ref.watch(apointmentListProvider);
                    return appointmentsList.when(
                      data: ((data) {
                        return data.isEmpty
                            ? const SizedBox(
                                height: 500,
                                child: Center(child: Text('No Appointments')),
                              )
                            : SizedBox(
                                height: 500,
                                child: ListView.builder(
                                  itemBuilder: (ctx, index) {
                                    return Padding(
                                      padding: const EdgeInsets.all(10),
                                      child: AppointmentCard(
                                        imageUrl: data[index]['image'],
                                        doctorName: data[index]['name'],
                                        doctorSpecialty: data[index]
                                            ['specialty'],
                                        date: data[index]['date'],
                                        sessionStart: data[index]['start'],
                                        sessionEnd: data[index]['end'],
                                      ),
                                    );
                                  },
                                  itemCount: data.length,
                                ),
                              );
                      }),
                      error: (val, stack) => const Center(
                        child: Text('Somethong went wrong..'),
                      ),
                      loading: () => const Center(
                        child: Text('Loading....'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ));
  }
}
