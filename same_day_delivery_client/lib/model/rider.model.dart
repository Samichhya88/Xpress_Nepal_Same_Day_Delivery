class RiderModel {
  String riderId;
  String riderName;
  String riderEmail;
  String riderPassword;
  String riderPhone;
  String riderAddress;
  DateTime riderDate;

  RiderModel({
    required this.riderId,
    required this.riderName,
    required this.riderEmail,
    required this.riderPassword,
    required this.riderPhone,
    required this.riderAddress,
    required this.riderDate,
  });

  Map<String, dynamic> toJson() {
    return {
      '_id': riderId,
      'rider_name': riderName,
      'rider_email': riderEmail,
      'rider_password': riderPassword,
      'rider_phone': riderPhone,
      'rider_address': riderAddress,
      'rider_date': riderDate,
    };
  }

  factory RiderModel.fromJson(Map<String, dynamic> json) {
    return RiderModel(
      riderId: json['_id'],
      riderName: json['rider_name'],
      riderEmail: json['rider_email'],
      riderPassword: json['rider_password'],
      riderPhone: json['rider_phone'],
      riderAddress: json['rider_address'],
      riderDate: json['rider_date'],
    );
  }
}
