class UserModel {
  final String name;
  final int age;
  final double weight;
  final int height;

  UserModel({
    required this.name,
    required this.age,
    required this.weight,
    required this.height,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      age: json['age'],
      weight: json['weight'],
      height: json['height'],
    );
  }
}
