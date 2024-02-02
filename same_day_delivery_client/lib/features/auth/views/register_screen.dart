import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/components/customScaffold.dart';
import 'package:same_day_delivery_client/components/customTextField.dart';
import 'package:same_day_delivery_client/features/auth/views/login_screen.dart';
import 'package:same_day_delivery_client/model/user.model.dart';
import 'package:same_day_delivery_client/services/api.dart';

class RegisterPage extends StatefulWidget {
  static const String imageURL =
      "https://toppng.com/uploads/preview/decorative-lines-vector-11549974585kzzlmrfrjk.png";
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController nameController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController phoneController = TextEditingController();

  final TextEditingController addressController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  bool isRider = false;

  // void _registerUser(BuildContext context) async {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(231, 255, 255, 255),
      body: SafeArea(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    const SizedBox(height: 50),
                    const Text(
                      'Register',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    CustomTextFromField(
                      label: 'username',
                      controller: nameController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFromField(
                      label: 'email',
                      controller: emailController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFromField(
                      label: 'password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFromField(
                      label: 'confirm password',
                      controller: confirmPasswordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: CustomTextFromField(
                            label: 'phone',
                            controller: phoneController,
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: CustomTextFromField(
                            label: 'address',
                            controller: addressController,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                            value: isRider,
                            onChanged: (p0) {
                              setState(() {
                                isRider = p0!;
                              });
                            }),
                        const Text('Are you a rider?'),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          if (passwordController.text !=
                              confirmPasswordController.text) {
                            showCustomSnackBar(
                              context,
                              message: "Passwords do not match",
                            );
                            return;
                          }

                          UserModel user = UserModel(
                            userId: DateTime.now()
                                .millisecondsSinceEpoch
                                .toString(), //timeand date id
                            userName: nameController.text,
                            userEmail: emailController.text,
                            userPassword: passwordController.text,
                            userPhone: [phoneController.text],
                            userAddress: addressController.text,
                            userDate: DateTime.now().toString(),
                            role: isRider ? "rider" : "user",
                          );
                          try {
                            await ApiService.registerUser(user);
                            showCustomSnackBar(
                              context,
                              message: "Registered Succesfully. Please Login!",
                              headingText: "Success!",
                              color: Colors.green,
                            );
                            Navigator.pop(context);
                          } on Exception catch (e) {
                            print(e.toString());
                            if (mounted) {
                              showCustomSnackBar(
                                context,
                                message:
                                    "Failed To register user ${e.toString()}",
                              );
                            }
                          }
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(width: 10),
                        const Text('Or'),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Container(
                            height: 1.0,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        const Text('Already have an account?'),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(
                              context,
                            );
                          },
                          child: const Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
