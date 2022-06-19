import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smartphone_disease_diagnosis/Models.dart';
import 'package:smartphone_disease_diagnosis/SignUp.dart';
import 'package:toast/toast.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _email = "", _password = "";
  bool _showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ToastContext().init(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
              child: Stack(children: <Widget>[
            Container(
              padding: const EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: const Text('Welcome To',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(100, 175.0, 0.0, 0.0),
              child: const Text('HelpO',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(260, 175.0, 0.0, 0.0),
              child: const Text('!',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54)),
            ),
          ])),
          Container(
              padding:
                  const EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
              child: Column(children: <Widget>[
                TextFormField(
                    //input email from user
                    validator: (input) {
                      if (input!.isEmpty) {
                        return 'Please Enter your E-mail';
                      }
                      return null;
                    },
                    onChanged: (val) {
                      setState(() => _email = val);
                    },
                    decoration: InputDecoration(
                      border: const OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: "E-mail",
                      hintStyle: new TextStyle(color: Colors.grey[1200]),
                    )),
                const SizedBox(height: 20.0),
                TextFormField(
                  //input email from user
                  validator: (input) {
                    if (input!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: !this._showPassword,
                  onChanged: (val) {
                    setState(() => _password = val);
                  },
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(20.0),
                      ),
                    ),
                    filled: true,
                    fillColor: Colors.white70,
                    hintText: "Password",
                    hintStyle: new TextStyle(color: Colors.grey[1200]),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.remove_red_eye,
                        color: this._showPassword ? Colors.blue : Colors.grey,
                      ),
                      onPressed: () {
                        setState(
                            () => this._showPassword = !this._showPassword);
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 40.0),
                Container(
                    height: 40.0,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlueAccent),
                          elevation: MaterialStateProperty.all(7),
                        ),
                        onPressed: signIn,
                        child: GestureDetector(
                            onTap: () {},
                            child: const Center(
                                child: Text('LOGIN',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    )))))),
                const SizedBox(height: 20.0),
                Container(
                    // Register Button
                    height: 40.0,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Colors.red),
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlueAccent),
                          elevation: MaterialStateProperty.all(7),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignPage()),
                          );
                        },
                        child: GestureDetector(
                            onTap: () {},
                            child: const Center(
                                child: Text('REGISTER',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: 'Montserrat',
                                    ))))))
              ])),
        ]),
      ),
    );
  }

  Future signIn() async {
    // "async" because we use a future to connect to Firebase user system
    final formState = _formKey.currentState;
    if (formState!.validate()) {
      formState.save();
      try {
        UserCredential user = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: _email, password: _password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Models()));
      } catch (e) {
        if (e.toString() == 'user-not-found') {
          Toast.show("Invalid E-mail",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        } else if (e.toString() == 'wrong-password') {
          Toast.show("Invalid Password",
              duration: Toast.lengthShort, gravity: Toast.bottom);
        } else {
          Toast.show("Invalid E-mail or Password",
              duration: Toast.lengthLong, gravity: Toast.bottom);
        }
      }
    }
  }
}
