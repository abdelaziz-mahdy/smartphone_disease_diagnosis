import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CloudFirestore {
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  Future uploadUserInfo(
      {required String name,
      required String address,
      required String email,
      String? gender,
      int? age,
      int? height,
      int? weight}) async {
    await firebaseFirestore
        .collection("Users")
        .doc(firebaseAuth.currentUser!.uid)
        .set({
      "name": name,
      "address": address,
      "email": email,
      "gender": gender,
      "height": height,
      "age": age,
      "weight": weight
    });
  }

  Future moreInfo(
      {String? gender, int? age, int? height, double? weight}) async {
    await firebaseFirestore
        .collection('Users')
        .doc(firebaseAuth.currentUser!.uid)
        .update(
            {"gender": gender, "height": height, "age": age, "weight": weight});
  }
}
