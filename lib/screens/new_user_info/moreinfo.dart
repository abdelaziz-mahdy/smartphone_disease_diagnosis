import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../Resources/cloud_firestore.dart';
import '../../state/sign_up_state_management.dart';
import '../new_user_info/ageslider.dart';
import '../new_user_info/gender.dart';
import '../new_user_info/heightslider.dart';
import '../new_user_info/weightslider.dart';
import '../tabs_screen.dart';

class MoreInfo extends StatefulWidget {
  const MoreInfo({Key? key}) : super(key: key);

  @override
  State<MoreInfo> createState() => _MoreInfoState();
}

class _MoreInfoState extends State<MoreInfo> {
  final pageController = PageController(initialPage: 0);
  void nextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  void uploadUserInfo(WidgetRef ref) {
    CloudFirestore().moreInfo(
      gender: ref.read(genderProvider.notifier).state,
      age: ref.read(ageProvider.notifier).state,
      height: ref.read(heightProvider.notifier).state,
      weight: ref.read(weightProvider.notifier).state,
    );

    Navigator.pushReplacementNamed(context, TabsScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: PageView(
            controller: pageController,
            children: [
              InfoPage(
                hero: const GenderSlide(),
                title: "What’s your gender?",
                onNext: () => nextPage(),
              ),
              InfoPage(
                hero: const AgeSlider(),
                title: "What’s your age?",
                onNext: () => nextPage(),
              ),
              InfoPage(
                hero: const HeightSlider(),
                title: "What’s your height?",
                onNext: () => nextPage(),
              ),
              Consumer(
                builder: (context, ref, child) => InfoPage(
                  hero: const WeightSlider(),
                  title: "What’s your weight?",
                  onNext: () => uploadUserInfo(ref),
                ),
              ),
            ],
          )),
    );
  }
}

class InfoPage extends StatelessWidget {
  final Widget hero;
  final String title;
  final VoidCallback onNext;
  const InfoPage({
    Key? key,
    required this.hero,
    required this.title,
    required this.onNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.1,
        ),
        Expanded(child: hero),
        ProgressButton(
          onNext: onNext,
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.04,
        ),
        const SizedBox(
          height: 4,
        ),
      ],
    );
  }
}

class ProgressButton extends StatelessWidget {
  final VoidCallback onNext;
  const ProgressButton({Key? key, required this.onNext}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 75,
      width: 75,
      child: Stack(
        children: [
          Center(
            child: GestureDetector(
              onTap: onNext,
              child: Container(
                height: 60,
                decoration:
                    const BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                child: const Center(
                  child: Icon(Icons.arrow_forward),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
