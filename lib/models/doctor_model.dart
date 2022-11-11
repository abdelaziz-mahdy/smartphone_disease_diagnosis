class DoctorModel {
  final String picture;
  final String name;
  final String specialty;
  final int sessionFee;
  final List<dynamic> workDays;
  final List<dynamic> workHours;
  final int sessionTime;
  final int yearsOfExperience;
  final String city;
  final String address;
  final double latitude;
  final double longitude;
  final double rating;
  final int numOfRatings;

  DoctorModel({
    required this.picture,
    required this.name,
    required this.specialty,
    required this.sessionFee,
    required this.workDays,
    required this.workHours,
    required this.sessionTime,
    required this.yearsOfExperience,
    required this.city,
    required this.address,
    required this.latitude,
    required this.longitude,
    this.rating = 0.0,
    this.numOfRatings = 0,
  });

  factory DoctorModel.fromJson(Map<String, dynamic> json) {
    return DoctorModel(
      picture: json['picture'],
      name: json['name'],
      specialty: json['specialty'],
      sessionFee: json['sessionFee'],
      workDays: json['workDays'],
      workHours: json['workHours'],
      sessionTime: json['sessionTime'],
      yearsOfExperience: json['yearsOfExperience'],
      city: json['city'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      rating: json['rating'],
      numOfRatings: json['numOfRatings'],
    );
  }

  Map<String, dynamic> toJson() => {
        'picture': picture,
        'name': name,
        'specialty': specialty,
        'sessionFee': sessionFee,
        'workDays': workDays,
        'workHours': workHours,
        'sessionTime': sessionTime,
        'yearsOfExperience': yearsOfExperience,
        'city': city,
        'address': address,
        'latitude': latitude,
        'longitude': longitude,
        'rating': rating,
        'numOfRatings': numOfRatings,
      };
}
