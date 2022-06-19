import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smartphone_disease_diagnosis/Login.dart';

class SignPage extends StatefulWidget {
  @override
  _SignPageState createState() => new _SignPageState();
}

class _SignPageState extends State<SignPage> {
  String newEmail = "", newPassword = "";
  bool _showPassword = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(),
      body: Form(
        key: _formKey,
        child: Column(children: <Widget>[
          Container(
              child: Stack(children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 110.0, 0.0, 0.0),
              child: Text('Sign Up',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(15.0, 175.0, 0.0, 0.0),
              child: Text('For HelpO',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent)),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(270, 175.0, 0.0, 0.0),
              child: Text(' !',
                  style: TextStyle(
                      fontSize: 60.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightBlueAccent)),
            ),
          ])),
          Container(
              padding: EdgeInsets.only(top: 35.0, left: 20.0, right: 20.0),
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
                      setState(() => newEmail = val);
                    },
                    decoration: InputDecoration(
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white70,
                      hintText: "E-mail",
                      hintStyle: new TextStyle(color: Colors.grey[1200]),
                    )),
                SizedBox(height: 20.0),
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
                    setState(() => newPassword = val);
                  },
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
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
                SizedBox(height: 40.0),
                Container(
                    height: 40.0,
                    child: ElevatedButton(
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: BorderSide(color: Colors.red),
                            ),
                          ),
                          foregroundColor: MaterialStateProperty.all<Color>(
                              Colors.lightBlueAccent),
                          elevation: MaterialStateProperty.all(7),
                        ),
                        onPressed: register,
                        child: GestureDetector(
                            onTap: () {},
                            child: Center(
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

  void register() async {
    //final _auth = FirebaseAuth.instance;
    Firebase.initializeApp();
    try {
      final _newUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: newEmail, password: newPassword);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print(e);
    }
  }
}
