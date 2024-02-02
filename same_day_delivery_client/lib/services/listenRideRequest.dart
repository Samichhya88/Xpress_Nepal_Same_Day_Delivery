import 'dart:async';

import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/components/customTextField.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';
import 'package:same_day_delivery_client/model/user.model.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

void listenRideRequest(BuildContext parentContext) async {
  final TextEditingController controller = TextEditingController();
  return socket.on(
      'request',
      (request) => {
            showDialog(
              context: parentContext,
              builder: (BuildContext context) {
                return Theme(
                  data: ThemeData.light(),
                  child: AlertDialog(
                    content: SizedBox(
                      height: 190,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Ride Request",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.person,
                                size: 30,
                              ),
                              Text(
                                "To: ${request[0]["endingPoint"]}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.shop_2_rounded,
                                size: 30,
                              ),
                              Text(
                                "From: ${request[0]["startingPoint"]}",
                                style: const TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomTextFromField(
                            label: "Set Bid",
                            controller: controller,
                            keyboardType: TextInputType.number,
                          )
                        ],
                      ),
                    ),
                    actions: [
                      CustomButton(
                        text: const Text("Set Bid"),
                        onPressed: () async {
                          if (controller.text.isEmpty) {
                            return;
                          }
                          final UserModel? user = await LocalStorage.getUser();
                          if (user == null) {
                            return;
                          }
                          if (user.role != "rider") {
                            return;
                          }
                          socket.emit('bid', {
                            "amount": controller.text.toString(),
                            "riderId": user.userId,
                            "userId": request[0]["userId"],
                          });

                          Navigator.pop(context);
                        },
                      ),

                      // FutureBuilder<UserModel?>(
                      //     future: LocalStorage.getUser(),
                      //     builder: (context, snapshot) {
                      //       if (snapshot.connectionState ==
                      //           ConnectionState.waiting) {
                      //         return CustomButton(
                      //             text: "Loding...", onPressed: () {});
                      //       }
                      //       return CustomButton(
                      //         text: const Text("Set Bid"),
                      //         onPressed: () {
                      //           if (controller.text.isEmpty) {
                      //             return;
                      //           }
                      //           // final UserModel? user = await LocalStorage.getUser();
                      //           if (snapshot.data == null) {
                      //             return;
                      //           }
                      //           if (snapshot.data!.role != "rider") {
                      //             return;
                      //           }
                      //           socket.emit('bid', {
                      //             "amount": controller.text.toString(),
                      //             "riderId": snapshot.data!.userId,
                      //             "userId": request[0]["userId"],
                      //           });

                      //           Navigator.pop(context);
                      //         },
                      //       );
                      //     }),
                      // ElevatedButton(
                      //   onPressed: () {
                      //     showDialog(
                      //         context: context,
                      //         builder: (BuildContext context) {
                      //           return BiddingPage();
                      //         });
                      //     // Navigator.push(context,
                      //     //     MaterialPageRoute(builder: (context) {
                      //     // return const BiddingPage();
                      //     // }));
                      //   },
                      //   child: const Text('Set Bid'),
                      // ),
                      // ElevatedButton(
                      //     onPressed: () {
                      //       Navigator.pop(context);
                      //     },
                      //     child: const Text('Cancle')),
                      const SizedBox(
                        width: 10,
                        height: 10,
                      ),
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(Icons.cancel),
                      )
                    ],
                  ),
                );
              },
            )
          });
}
