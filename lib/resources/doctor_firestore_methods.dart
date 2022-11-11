import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/search_filters_model.dart';

Query<Map<String, dynamic>> filterDoctorsCollection(FiltersModel filters) {
  Query<Map<String, dynamic>> collectionRef =
      FirebaseFirestore.instance.collection("Doctors");

  if (filters.specialty != 'all') {
    collectionRef =
        collectionRef.where('specialty', isEqualTo: filters.specialty);
  }
  if (filters.city != 'any') {
    collectionRef = collectionRef.where('city', isEqualTo: filters.city);
  }
  if (filters.priceLow != 0) {
    collectionRef = collectionRef.where('sessionFee',
        isGreaterThanOrEqualTo: filters.priceLow);
  }
  if (filters.priceHigh != null) {
    collectionRef =
        collectionRef.where('sessionFee', isLessThan: filters.priceHigh);
  }

  return collectionRef;
}

Future<List<DocumentSnapshot>> getFilteredDoctorsList(FiltersModel filters) async {
  List<DocumentSnapshot> filteredDoctors = [];
  bool noAdditionalFilters = filters.yearsOfExperience == 0 && filters.rating == 0;
  QuerySnapshot<Map<String, dynamic>> snap =
      await filterDoctorsCollection(filters).get();

  for (int i = 0; i < snap.docs.length; i++) {
    DocumentSnapshot docSnap = snap.docs[i];
    filteredDoctors.add(docSnap);
  }

  if (!noAdditionalFilters) {
    if (filters.rating != 0) {
      filteredDoctors = filteredDoctors
          .where((element) => element['rating'] >= filters.rating)
          .toList();
    }

    if (filters.yearsOfExperience != 0) {
      filteredDoctors = filteredDoctors
          .where((element) =>
              element['yearsOfExperience'] >= filters.yearsOfExperience)
          .toList();
    }
  }

  return filteredDoctors;
}


