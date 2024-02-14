import 'package:flutter/material.dart';

class RiderHomePage extends StatefulWidget {
  const RiderHomePage({Key? key}) : super(key: key);

  @override
  State<RiderHomePage> createState() => _RiderHomePageState();
}

class _RiderHomePageState extends State<RiderHomePage> {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    // Start the animation after 1 second (1000 milliseconds)
    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              height: _opacity == 0.0 ? 0.0 : 150.0,
              width: _opacity == 0.0 ? 0.0 : 150.0,
              child: FadeInImage.assetNetwork(
                placeholder: 'assets/images/xpress.png',
                image:
                    'https://i.pinimg.com/originals/08/f1/8f/08f18f99279bfc06cdcab2d5ca1227e2.gif',
              ),
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: const SizedBox(height: 20.0),
            ),
            AnimatedOpacity(
              opacity: _opacity,
              duration: const Duration(seconds: 1),
              child: const Text(
                "You will be notified when a ride request is available.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
