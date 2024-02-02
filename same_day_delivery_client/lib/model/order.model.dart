class Order {
  String orderId;
  String userId;
  String serviceId;
  String riderId;
  String orderStatus;
  String orderDate;
  num orderAmount;
  String orderAddress;
  String orderDescription;
  String orderStartingPoint;
  String orderEndingPoint;
  String orderInitiateDate;
  String orderCompletionDate;
  num deliveryCharge;

  Order({
    required this.orderId,
    required this.userId,
    required this.serviceId,
    required this.riderId,
    required this.orderStatus,
    required this.orderDate,
    required this.orderAmount,
    required this.orderAddress,
    required this.orderDescription,
    required this.orderStartingPoint,
    required this.orderEndingPoint,
    required this.orderInitiateDate,
    required this.orderCompletionDate,
    required this.deliveryCharge,
  });

  Map<String, dynamic> toJson() {
    return {
      'order_id': orderId,
      'user_id': userId,
      'service_id': serviceId,
      'rider_id': riderId,
      'order_status': orderStatus,
      'order_date': orderDate,
      'order_amount': orderAmount,
      'order_address': orderAddress,
      'order_description': orderDescription,
      'order_starting_point': orderStartingPoint,
      'order_ending_point': orderEndingPoint,
      'order_initiate_date': orderInitiateDate,
      'order_completion_date': orderCompletionDate,
      'delivery_charge': deliveryCharge,
    };
  }

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      orderId: json['order_id'],
      userId: json['user_id'],
      serviceId: json['service_id'],
      riderId: json['rider_id'],
      orderStatus: json['order_status'],
      orderDate: json['order_date'],
      orderAmount: json['order_amount'],
      orderAddress: json['order_address'],
      orderDescription: json['order_description'],
      orderStartingPoint: json['order_starting_point'],
      orderEndingPoint: json['order_ending_point'],
      orderInitiateDate: json['order_initiate_date'],
      orderCompletionDate: json['order_completion_date'],
      deliveryCharge: json['delivery_charge'],
    );
  }
}
