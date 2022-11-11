import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../resources/auth.dart';
import '../../utils/utils.dart';
import '../../widgets/authorization_widgets/main_button.dart';
import '../../widgets/authorization_widgets/or_divider.dart';
import '../../widgets/authorization_widgets/social_icon.dart';
import '../../widgets/authorization_widgets/textfield.dart';
import '../new_user_info/moreinfo.dart';
import 'sign_in.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController namecotroller = TextEditingController();
    TextEditingController adressscontroller = TextEditingController();
    TextEditingController emailcontroller = TextEditingController();
    TextEditingController passwordcontroller = TextEditingController();
    AuthenticationMethods authenticationMethods = AuthenticationMethods();

    // @override
    // void dispose() {
    //   namecotroller.dispose();
    //   adressscontroller.dispose();
    //   emailcontroller.dispose();
    //   passwordcontroller.dispose();
    // 


    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Image(
            image: Svg('assets/images/back_arrow.svg'),
            width: 24,
            color: Colors.blue,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Register",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 30),
                      ),
                      const Text(
                        "Create new account to get started",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 40,
                      ),
                      TextFieldWidget(
                        controller: namecotroller,
                        obscureText: false,
                        hintText: "Enter your Name",
                      ),
                      TextFieldWidget(
                        controller: adressscontroller,
                        obscureText: false,
                        hintText: "Enter your Address",
                      ),
                      TextFieldWidget(
                        controller: emailcontroller,
                        obscureText: false,
                        hintText: "Enter your Email",
                      ),
                      TextFieldWidget(
                        controller: passwordcontroller,
                        obscureText: true,
                        hintText: "Enter your Password",
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  MainButton(
                      buttonName: 'Register',
                      onTap: () async {
                        String output = await authenticationMethods.usersignUp(
                            name: namecotroller.text,
                            address: adressscontroller.text,
                            password: passwordcontroller.text,
                            email: emailcontroller.text);

                        if (output == "success") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => const MoreInfo()));
                        } else {
                          Utils()
                              .showSnackBar(context: context, content: output);
                        }
                      },
                      backgroundColor: Colors.blue,
                      textColor: Colors.white),
                  const OrDivider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialIcon(
                        iconName: 'assets/images/facebook.svg',
                        press: () {},
                      ),
                      SocialIcon(
                        iconName: 'assets/images/twitter.svg',
                        press: () {},
                      ),
                      SocialIcon(
                        iconName: 'assets/images/facebook.svg',
                        press: () {},
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 15),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) => const SignIn()));
                        },
                        child: const Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 15,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
