import 'package:concentric_transition/concentric_transition.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../screens/SignInUp/signoptions.dart';
import '../widgets/authorization_widgets/card_planet.dart';



class OnboardingPage extends StatelessWidget {
  OnboardingPage({Key? key}) : super(key: key);

  final data = [
    OnboardingCardData(
      title: "Diagnosis",
      subtitle: "Get automatic AI diagnosis",
      image: LottieBuilder.asset(
        "assets/images/1.json",
        width: 400,
        height: 400,
      ),
      backgroundColor: Colors.white,
      titleColor: Colors.black,
      subtitleColor: Colors.black,
      background: LottieBuilder.asset("assets/images/bg-1.json"),
    ),
    OnboardingCardData(
      title: "Organization",
      subtitle: "Keep medical records in one place",
      image: LottieBuilder.asset(
        "assets/images/file.json",
        width: 500,
        height: 500,
      ),
      backgroundColor: Colors.blue.shade200,
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/images/bg-2.json"),
    ),
    OnboardingCardData(
      title: "Booking",
      subtitle: "Book appoinments with experts in the field.",
      image: LottieBuilder.asset("assets/images/doctor.json"),
      backgroundColor: Colors.pink.shade200,
      titleColor: Colors.white,
      subtitleColor: Colors.white,
      background: LottieBuilder.asset("assets/images/bg-3.json"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ConcentricPageView(
        colors: data.map((e) => e.backgroundColor).toList(),
        itemCount: data.length,
        itemBuilder: (int index) {
          return OnboardingCard(data: data[index]);
        },
        onFinish: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const SignOptions()),
          );
        },
      ),
    );
  }
}
