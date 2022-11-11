import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import './screens/booking_screen.dart';
import './screens/tabs_screen.dart';
import './screens/onboarding_screen.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, AsyncSnapshot<User?> user) {
          if (user.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (user.hasError) {
            return const Center(
              child: Text('something went wrong!'),
            );
          } else if (user.hasData) {
            print('logged in');
            return const TabsScreen();
          } else {
            print('logged out');
            return OnboardingPage();
          }
        },
      ),
      routes: {
        TabsScreen.routeName: (context) => const TabsScreen(),
        BookAppointment.routeName: (context) => const BookAppointment(),
      },
    );
  }
}
