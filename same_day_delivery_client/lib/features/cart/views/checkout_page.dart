// ignore_for_file: must_be_immutable

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/components/customScaffold.dart';
import 'package:same_day_delivery_client/components/location_selector.dart';
import 'package:same_day_delivery_client/model/cart.item.model.dart';
import 'package:same_day_delivery_client/routes.dart';
import 'package:same_day_delivery_client/services/location.dart';

class CheckoutPage extends StatefulWidget {
  final List<CartItem> cartItems;
  const CheckoutPage({super.key, required this.cartItems});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  GeoPoint? pickedLocation;

  String selectedPaymentMethod = '';

  @override
  Widget build(BuildContext context) {
    print(widget.cartItems.length);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Check Out",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.grey[800],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            OrderSummary(checkedItems: widget.cartItems),
            DeliveryPlace(
              pickedLocation: pickedLocation,
              onLocationSelected: (p0) {
                setState(() {
                  pickedLocation = p0;
                });
              },
            ),
            PaymentMethod(
                selectedPaymentMethod: selectedPaymentMethod,
                onPaymentMethodSelected: (String paymentMethod) {
                  setState(() {
                    selectedPaymentMethod = paymentMethod;
                  });
                }),
            PayementDetail(checkedItems: widget.cartItems),
            Container(
                height: 82,
                color: const Color.fromARGB(255, 240, 239, 239),
                child: PlaceOrder(
                  pickedLocation: pickedLocation,
                  cartItems: widget.cartItems,
                ))
          ],
        ),
      ),
      bottomNavigationBar: const BottomAppBar(
        height: 62,
      ),
    );
  }
}

class OrderSummary extends StatelessWidget {
  final List<CartItem> checkedItems;

  const OrderSummary({super.key, required this.checkedItems});

  @override
  Widget build(BuildContext context) {
    print(checkedItems.length);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Text(
            "ORDER SUMMARY",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
        ),
        const Divider(
          thickness: 3,
          indent: 20,
          endIndent: 200,
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ItemDetail(
              item: checkedItems[index],
            );
          },
          separatorBuilder: (context, index) {
            return const Divider();
          },
          itemCount: checkedItems.length,
        ),
      ],
    );
  }
}

class ItemDetail extends StatelessWidget {
  final CartItem item;

  const ItemDetail({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(16)),
        height: 110,
        width: double.infinity,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image(
                width: 130,
                image: NetworkImage(
                  item.imageUrl,
                ),
                fit: BoxFit.fill,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  item.title,
                  style: TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
                Text(
                  item.addedDate,
                  style: const TextStyle(
                    overflow: TextOverflow.ellipsis,
                    fontSize: 10,
                    color: Color.fromARGB(255, 150, 150, 150),
                  ),
                ),
                const SizedBox(
                  height: 14,
                ),
                Row(
                  children: [
                    Text(
                      "Price:Rs. ${item.price},",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[800],
                      ),
                    ),
                    const SizedBox(
                      width: 100,
                    ),
                    Text(
                      "Qty:${item.quantity}",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Color.fromARGB(255, 150, 150, 150),
                      ),
                    ),
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DeliveryPlace extends StatefulWidget {
  final Function(GeoPoint) onLocationSelected;
  GeoPoint? pickedLocation;
  DeliveryPlace(
      {super.key, this.pickedLocation, required this.onLocationSelected});

  @override
  State<DeliveryPlace> createState() => _DeliveryPlaceState();
}

class _DeliveryPlaceState extends State<DeliveryPlace> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Text(
            "DELIVERY TO",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
        ),
        const Divider(
          thickness: 3,
          indent: 20,
          endIndent: 200,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              LocationSelector(
                onLocationSelected: (p0) {
                  setState(() {
                    widget.pickedLocation = p0;
                    widget.onLocationSelected(p0);
                  });
                },
              ),
              const SizedBox(
                width: 15,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recipient",
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  const Text(
                    'Contact:9865374628',
                    style: TextStyle(
                      fontSize: 13,
                      color: Color.fromARGB(255, 116, 116, 116),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  widget.pickedLocation == null
                      ? const Text(
                          "Select delivery location",
                          style: TextStyle(
                            fontSize: 13,
                            color: Color.fromARGB(255, 116, 116, 116),
                          ),
                        )
                      : FutureBuilder(
                          future: LocationService()
                              .getPlaceName(widget.pickedLocation!),
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Text(
                                "Loading location...",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromARGB(255, 116, 116, 116),
                                ),
                              );
                            }
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  snapshot.data!.name!,
                                  style: const TextStyle(
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 116, 116, 116),
                                  ),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                snapshot.data!.locality! == null
                                    ? const SizedBox()
                                    : Text(
                                        "${snapshot.data!.locality!}, ${snapshot.data!.country!}",
                                        style: const TextStyle(
                                          fontSize: 13,
                                          color: Color.fromARGB(
                                              255, 116, 116, 116),
                                        ),
                                      ),
                              ],
                            );
                          },
                        ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}

class PaymentMethod extends StatefulWidget {
  final String selectedPaymentMethod;
  final Function(String) onPaymentMethodSelected;

  const PaymentMethod({
    super.key,
    required this.selectedPaymentMethod,
    required this.onPaymentMethodSelected,
  });

  @override
  State<PaymentMethod> createState() => _PaymentMethodState();
}

class _PaymentMethodState extends State<PaymentMethod> {
  final config = PaymentConfig(
    amount: 10000, // Amount should be in paisa
    productIdentity: 'dell-g5-g5510-2021',
    productName: 'Dell G5 G5510 2021',
    productUrl: 'https://www.khalti.com/#/bazaar',
    additionalData: {
      // Not mandatory; can be used for reporting purpose
      'vendor': 'Khalti Bazaar',
    },
    mobile:
        '9800000001', // Not mandatory; can be used to fill mobile number field
  );
  bool cashOnDeliveryChecked = false;
  bool digitalPaymentChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Text(
            "PAYMENT METHOD",
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
        ),
        const Divider(
          thickness: 3,
          indent: 20,
          endIndent: 200,
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
          child: Container(
            height: 50,
            width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(children: [
              const SizedBox(
                width: 8,
              ),
              const Icon(Icons.money),
              const SizedBox(
                width: 10,
              ),
              Text(
                "Cash on Delivery",
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey[800],
                ),
              ),
              const Spacer(),
              Checkbox(
                activeColor: MaterialStateColor.resolveWith(
                  (states) => Colors.grey,
                ),
                value: cashOnDeliveryChecked,
                onChanged: (bool? value) {
                  setState(() {
                    cashOnDeliveryChecked = value!;
                    widget.onPaymentMethodSelected(
                      cashOnDeliveryChecked
                          ? "Cash on Delivery"
                          : digitalPaymentChecked
                              ? "Digital payment"
                              : "",
                    );
                  });
                },
              ),
            ]),
          ),
        ),
        KhaltiButton(
          config: config,
          preferences: [
            // Not providing this will enable all the payment methods.
            PaymentPreference.khalti,
            PaymentPreference.eBanking,
            PaymentPreference.mobileBanking,
          ],
          onSuccess: (successModel) {
            // Perform Server Verification
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: const Text('Payment Successful'),
                  actions: [
                    SimpleDialogOption(
                        child: const Text('OK'),
                        onPressed: () {
                          setState(() {
                            successModel.idx!;
                          });

                          Navigator.pop(context);
                        })
                  ],
                );
              },
            );
            showCustomSnackBar(context, message: "Payment successful");
          },
          onFailure: (failureModel) {
            showCustomSnackBar(context,
                message: "Payment failed", color: Colors.red);
          },
          onCancel: () {
            showCustomSnackBar(context,
                message: "Payment cancelled", color: Colors.red);
          },
          label: "Pay With Khalti",
        ),
        // Padding(
        //   padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
        //   child: Container(
        //     height: 50,
        //     width: double.infinity,
        //     decoration: BoxDecoration(
        //       border: Border.all(color: Colors.grey),
        //       borderRadius: BorderRadius.circular(10),
        //     ),
        //     child: Row(children: [
        //       const SizedBox(
        //         width: 8,
        //       ),
        //       const Icon(Icons.web),
        //       const SizedBox(
        //         width: 10,
        //       ),
        //       Text(
        //         "Digital payment",
        //         style: TextStyle(
        //           fontSize: 15,
        //           fontWeight: FontWeight.w500,
        //           color: Colors.grey[800],
        //         ),
        //       ),
        //       const Spacer(),
        //       Checkbox(
        //         activeColor: MaterialStateColor.resolveWith(
        //           (states) => Colors.grey,
        //         ),
        //         value: digitalPaymentChecked,
        //         onChanged: (bool? value) {
        //           setState(() {
        //             digitalPaymentChecked = value!;
        //             widget.onPaymentMethodSelected(
        //               digitalPaymentChecked
        //                   ? "Digital payment"
        //                   : cashOnDeliveryChecked
        //                       ? "Cash on Delivery"
        //                       : "",
        //             );
        //           });
        //         },
        //       ),
        //     ]),
        //   ),
        // )
      ],
    );
  }
}

class PayementDetail extends StatelessWidget {
  final List<CartItem> checkedItems;

  const PayementDetail({super.key, required this.checkedItems});

  @override
  Widget build(BuildContext context) {
    double totalprice = 0;
    double deliveryfee = 100;

    for (int i = 0; i < checkedItems.length; i++) {
      totalprice += checkedItems[i].price;
    }

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: const Color.fromARGB(255, 243, 241, 241),
        ),
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              PriceList(detail: "Delivery Fee", price: '$deliveryfee'),
              PriceList(detail: "Discount", price: '0'),
              PriceList(detail: "Items total", price: '$totalprice'),
              PriceList(
                  detail: "Total payment",
                  price: (totalprice + deliveryfee).toString())
            ],
          ),
        ),
      ),
    );
  }
}

class PriceList extends StatelessWidget {
  final String detail;
  final String price;

  const PriceList({super.key, required this.detail, required this.price});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          detail,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
        ),
        Text(
          price,
          style: const TextStyle(
            fontSize: 14,
            color: Color.fromARGB(255, 116, 116, 116),
          ),
        ),
      ],
    );
  }
}

class PlaceOrder extends StatefulWidget {
  GeoPoint? pickedLocation;
  List<CartItem> cartItems;

  PlaceOrder({
    super.key,
    required this.pickedLocation,
    required this.cartItems,
  });

  @override
  State<PlaceOrder> createState() => _PlaceOrderState();
}

class _PlaceOrderState extends State<PlaceOrder> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.cartItems[0].id);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total Price",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: CustomButton(
                onPressed: () async {
                  final currentPosition = await LocationService().getLocation();

                  if (widget.pickedLocation == null) {
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(
                    //     content: Text("Please select delivery location"),
                    //   ),
                    // );
                    showCustomSnackBar(context,
                        message: "You forgot to select location");
                    return;
                  }
                  goRouter.push("/cart/riderPage", extra: {
                    "endpoint": widget.pickedLocation,
                    "startingPoint": GeoPoint(
                      latitude: currentPosition.latitude,
                      longitude: currentPosition.longitude,
                    ),
                    "products": widget.cartItems,
                  });
                },
                text: Text(
                  "Place Order",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
