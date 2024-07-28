import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../widgets/scan_widgets/diagnosis_image_widget.dart';
import '../widgets/scan_widgets/info_card.dart';

class ScanHomeScreen extends StatelessWidget {
  const ScanHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.only(
                  left: 20, top: 0, right: 20, bottom: 20),
              width: double.infinity,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Column(
                children: <Widget>[
                  Row(
                    children: [
                      Expanded(
                        child: InfoCard(
                          title: "Past AI check-ups",
                          iconColor: Colors.blue,
                          subtitle: '3 check-ups',
                          press: () {},
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Wrap(
                    spacing: 20,
                    runSpacing: 20,
                    children: [
                      InfoCard(
                        title: "Learn About",
                        iconColor: Colors.blue,
                        subtitle: 'Our AI',
                        press: () {},
                      ),
                      InfoCard(
                        title: "View",
                        iconColor: Colors.blue,
                        subtitle: ' Records',
                        press: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Diseases",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        CategoryCard(
                          img: "assets/icons/dental_icon.png",
                          title: "Dental",
                          press: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => DiagnosisImageWidget(
                                closeHandler: () => Navigator.of(context).pop(),
                                diagnosisModel: 'dental',
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          img: "assets/icons/skin_icon.png",
                          title: "Skin",
                          press: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (_) => DiagnosisImageWidget(
                                closeHandler: () => Navigator.of(context).pop(),
                                diagnosisModel: 'skin',
                              ),
                            );
                          },
                        ),
                        CategoryCard(
                          img: "",
                          title: "Covid",
                          press: () {},
                        ),
                      ],
                    ),
                    buildHelpCard(context)
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }

  Widget buildHelpCard(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        height: 160,
        width: double.infinity,
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(
                // left side padding is 40% of total width
                left: MediaQuery.of(context).size.width * .4,
                top: 30,
                right: 20,
              ),
              height: 130,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xFFCFDDFD),
                    Color(0xFF4378DB),
                  ],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "View Check-up \nTutorial\n",
                      style: Theme.of(context)
                          .textTheme
                          .headlineLarge
                          ?.copyWith(color: Colors.white),
                    ),
                    TextSpan(
                      text: "step by step guide",
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
                height: 250,
                width: 150,
                child: Image.asset('assets/icons/bot2.png')),
            Positioned(
              top: 30,
              right: 10,
              child: SvgPicture.asset("assets/icons/virus.svg"),
            ),
          ],
        ),
      ),
    );
  }
}


class CategoryCard extends StatelessWidget {
  final String img;
  final String title;
  final Function()? press;
  const CategoryCard({
    Key? key,
    required this.img,
    required this.title,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: press,
          child: Container(
            height: 65,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: img == "" ? const Color.fromARGB(255, 244, 244, 244) : Colors.white,
            ),
            child: img == "" ? null : Image.asset(img),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          title,
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(fontWeight: FontWeight.w600),
        )
      ],
    );
  }
}
