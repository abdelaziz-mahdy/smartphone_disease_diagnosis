import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../tabs_screen.dart';
import '../../resources/auth.dart';
import '../../utils/utils.dart';
import '../../widgets/authorization_widgets/main_button.dart';
import '../../widgets/authorization_widgets/or_divider.dart';
import '../../widgets/authorization_widgets/social_icon.dart';
import '../../widgets/authorization_widgets/textfield.dart';
import './register.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  AuthenticationMethods authenticationMethods = AuthenticationMethods();
  @override
  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }

  bool isPasswordVisible = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Image(
            image: Svg('assets/images/back_arrow.svg'),
            color: Colors.blue,
            width: 24,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SafeArea(
          child: CustomScrollView(
        reverse: true,
        slivers: [
          SliverFillRemaining(
            hasScrollBody: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 50.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back.',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 34),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "You've been missed!",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      TextFieldWidget(
                        obscureText: false,
                        controller: emailcontroller,
                        hintText: "enter your email",
                      ),
                      TextFieldWidget(
                        controller: passwordcontroller,
                        obscureText: true,
                        hintText: "Enter your Password",
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30.0),
                    child: MainButton(
                        buttonName: "Sign In",
                        onTap: () async {
                          String output =
                              await authenticationMethods.signInUser(
                                  email: emailcontroller.text,
                                  password: passwordcontroller.text);
                          if (output == "success") {
                            Navigator.pushReplacementNamed(context, TabsScreen.routeName);

                          } else {
                            Utils().showSnackBar(
                                context: context, content: output);
                          }
                        },
                        backgroundColor: Colors.blue,
                        textColor: Colors.white),
                  ),
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
                    height: 50,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account? "),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              CupertinoPageRoute(
                                  builder: (context) =>
                                      const RegisterScreen()));
                        },
                        child: const Text(
                          "Register",
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
