import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';

class BiddingPage extends StatefulWidget {
  const BiddingPage({super.key});

  @override
  State<BiddingPage> createState() => _BiddingPageState();
}

class _BiddingPageState extends State<BiddingPage> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var parentContext = context;
    socket.on(
        'success',
        (data) => {
              showDialog(
                context: parentContext,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text(data[0]),
                    actions: [
                      ElevatedButton(
                          onPressed: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return BiddingPage();
                            }));
                          },
                          child: Text('Start Ride')),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancle')),
                    ],
                  );
                },
              )
            });
    return Scaffold(
        body: SafeArea(
      child: Center(
        child: Column(children: [
          const Text('Bidding request from x to y at Rs 500'),
          TextField(
            controller: _textEditingController,
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
              FilteringTextInputFormatter.digitsOnly
            ],
          ),
          ElevatedButton(
              onPressed: () {
                socket.emit('bid', {
                  "amount": _textEditingController.text,
                  "riderId": '12345',
                  "userId": '56789',
                });
              },
              child: const Text('Send Bid'))
        ]),
      ),
    ));
  }
}
