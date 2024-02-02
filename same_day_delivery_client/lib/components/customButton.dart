import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final dynamic text;
  final VoidCallback onPressed;
  final Color color;
  const CustomButton({
    required this.text,
    required this.onPressed,
    super.key,
    this.color = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            foregroundColor: MaterialStateColor.resolveWith(
              (states) => Colors.white,
            ),
            splashFactory: NoSplash.splashFactory,
            backgroundColor: MaterialStateProperty.all(color),
            padding: MaterialStateProperty.all(
              const EdgeInsets.symmetric(vertical: 20),
            ),
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
          child: text.runtimeType == String
              ? Text(
                  text,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : text),
    );
  }
}
