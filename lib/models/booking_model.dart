class BookingModel {
  final DateTime timestamp;
  final String doctorId;
  final String userId;

  BookingModel({
    required this.timestamp,
    required this.doctorId,
    required this.userId,
  });

  factory BookingModel.fromJson(Map<String, dynamic> json) {
    return BookingModel(
      timestamp: json['timestamp'],
      doctorId: json['doctorId'],
      userId: json['userId'],
    );
  }

  Map<String, dynamic> toJson() => {
        'timestamp': timestamp,
        'doctorId': doctorId,
        'userId': userId,
      };
}
