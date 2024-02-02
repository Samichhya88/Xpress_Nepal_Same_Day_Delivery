class NotificationModel {
  String notificationId;
  String orderId;
  String notificationType;
  String notificationTitle;
  String notificationDescription;
  DateTime notificationDate;

  NotificationModel({
    required this.notificationId,
    required this.orderId,
    required this.notificationType,
    required this.notificationTitle,
    required this.notificationDescription,
    required this.notificationDate,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificationId: json['notificationId'],
      orderId: json['orderId'],
      notificationType: json['notificationType'],
      notificationTitle: json['notificationTitle'],
      notificationDescription: json['notificationDescription'],
      notificationDate: DateTime.parse(json['notificationDate']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'notificationId': notificationId,
      'orderId': orderId,
      'notificationType': notificationType,
      'notificationTitle': notificationTitle,
      'notificationDescription': notificationDescription,
      'notificationDate': notificationDate.toIso8601String(),
    };
  }
}
