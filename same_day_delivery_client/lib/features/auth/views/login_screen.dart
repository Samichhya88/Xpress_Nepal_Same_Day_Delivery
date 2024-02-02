import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:same_day_delivery_client/components/customButton.dart';
import 'package:same_day_delivery_client/components/customScaffold.dart';
import 'package:same_day_delivery_client/components/customTextField.dart';
import 'package:same_day_delivery_client/features/auth/views/register_screen.dart';
import 'package:same_day_delivery_client/features/rider/views/rider_only_page.dart';
import 'package:same_day_delivery_client/features/socket/socketConnection.dart';
import 'package:same_day_delivery_client/model/user.model.dart';
import 'package:same_day_delivery_client/routes.dart';
import 'package:same_day_delivery_client/services/api.dart';
import 'package:same_day_delivery_client/services/localStorage.dart';

class LoginPage extends StatelessWidget {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  static const String imageURL =
      "https://toppng.com/uploads/preview/decorative-lines-vector-11549974585kzzlmrfrjk.png";
  LoginPage({super.key});
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
                    // Stack(
                    //   children: [
                    //     SizedBox(
                    //       height: 150,
                    //       width: double.infinity,
                    //       child: Image.network(
                    //         imageURL,
                    //         fit: BoxFit.fill,
                    //       ),
                    //     ),
                    //     const Positioned(
                    //       top: 30,
                    //       left: 20,
                    //       child: Text(
                    //         'Same Day Delivery',
                    //         style: TextStyle(
                    //           color: Colors.black,
                    //           fontSize: 24,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(height: 150),
                    const Text(
                      'Login',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Center(
                      child: Image.asset(
                        'assets/images/xpress.png',
                        height: 200,
                      ),
                    ),
                    CustomTextFromField(
                      label: 'email',
                      controller: nameController,
                    ),
                    const SizedBox(height: 20),
                    CustomTextFromField(
                      label: 'password',
                      controller: passwordController,
                      isPassword: true,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: const Text(
                        'Login',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                        ),
                      ),
                      onPressed: () async {
                        try {
                          final response = await ApiService.signInUser(
                              nameController.text, passwordController.text);
                          if (response == null) {
                            showCustomSnackBar(context,
                                message: "Something went wrong!");
                            return;
                          }
                          if (response["success"]) {
                            if (response["user"]["role"] == "rider") {
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return RiderHomePage();
                              })
                              );
                              socket.emit('riderConnected', {response["user"]});
                              showCustomSnackBar(
                              context,
                              message: "You are now connected as a rider!",
                              color: Colors.green,
                              headingText: "Success!",
                            );
                            return;
                            }
                            goRouter.goNamed("home");
                            showCustomSnackBar(
                              context,
                              message: response["message"],
                              color: Colors.green,
                              headingText: "Success!",
                            );
                            return;
                          } else if (response["message"] ==
                              "Invalid Credentials") {
                            showCustomSnackBar(context,
                                message: "Invalid credentials");
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(response["message"]),
                              ),
                            );
                          }
                        } catch (e) {
                          if (e is DioException &&
                              e.response!.statusCode == 400) {
                            showCustomSnackBar(context,
                                message: "Invalid credentials");
                          }
                          return;
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
                        const Text("Don't have an account?"),
                        const SizedBox(width: 10),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => RegisterPage(),
                                ));
                          },
                          child: const Text(
                            'Create Now',
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
