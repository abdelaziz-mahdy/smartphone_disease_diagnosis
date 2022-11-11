import 'package:firebase_auth/firebase_auth.dart';

import './cloud_firestore.dart';

class AuthenticationMethods {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  CloudFirestore cloudFirestore = CloudFirestore();

  Future<String> usersignUp(
      {required String name,
      required String address,
      required String password,
      required String email}) async {
    name.trim();
    address.trim();
    email.trim();
    password.trim();
    String output = "Error";
    if (name != "" && address != "" && email != "" && password != "") {
      try {
        await firebaseAuth.createUserWithEmailAndPassword(
            email: email, password: password);

        await cloudFirestore.uploadUserInfo(
            name: name.split(" ").map((str) =>'${str[0].toUpperCase()}${str.substring(1).toLowerCase()}').join(" "),
            address: address,
            email: email,
            age: null,
            gender: null,
            height: null,
            weight: null);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = " Error, please fill all the missing information!";
    }
    return output;
  }

  Future<String> signInUser(
      {required String email, required String password}) async {
    email.trim();
    password.trim();
    String output = "Something went wrong";
    if (email != "" && password != "") {
      try {
        await firebaseAuth.signInWithEmailAndPassword(
            email: email, password: password);
        output = "success";
      } on FirebaseAuthException catch (e) {
        output = e.message.toString();
      }
    } else {
      output = "Please fill up all the fields.";
    }
    return output;
  }
}
