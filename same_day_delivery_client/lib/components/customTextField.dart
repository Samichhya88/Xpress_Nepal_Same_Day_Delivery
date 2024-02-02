import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextFromField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final int maxlines;
  bool isPassword;
  final TextInputType keyboardType;
  CustomTextFromField({
    super.key,
    required this.label,
    required this.controller,
    this.isPassword = false,
    this.maxlines = 1,
    this.keyboardType = TextInputType.text,
  });

  @override
  State<CustomTextFromField> createState() => _CustomTextFromFieldState();
}

class _CustomTextFromFieldState extends State<CustomTextFromField> {
  bool passwordVisible = false;
  ValueNotifier<bool> hasError = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    passwordVisible = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 7,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        height: 50,
        child: ValueListenableBuilder(
            valueListenable: hasError,
            builder: (context, value, child) {
              // })
              return TextFormField(
                cursorColor: Colors.black,
                maxLines: widget.maxlines,
                controller: widget.controller,
                obscureText: passwordVisible,
                obscuringCharacter: "*",
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                decoration: InputDecoration(
                  errorBorder: hasError.value
                      ? OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(
                            color: Colors.red,
                          ),
                        )
                      : null,
                  // helperText: ,
                  error: null,
                  suffixIcon: widget.isPassword
                      ? IconButton(
                          color: Colors.grey,
                          onPressed: () {
                            setState(() {
                              passwordVisible = !passwordVisible;
                            });
                          },
                          icon: Icon(
                            passwordVisible
                                ? Icons.lock_outline
                                : Icons.lock_open,
                            color: Colors.grey,
                          ),
                        )
                      : null,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: widget.label,
                  hintStyle: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    setState(() {
                      hasError.value = true;
                    });
                    return 'Field Cannot be empty';
                  }
                  return null;
                },
              );
            }));

    // );
  }
}
