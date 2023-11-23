import 'package:block_chain/blockchain_wallet/presentation/pages/screen.dart';
import 'package:flutter/material.dart';

import '../../../shared/network/firebase/firebase_manager.dart';
import '../../../sign_sup/presentation/pages/sign_up.dart';

class LoginScreen extends StatelessWidget {
  static const routeName = "Login";
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("please log in to access your wallet"),
          bottom: const TabBar(
            tabs: [
              Tab(
                text: "login",
              ),
              Tab(
                text: "signUp",
              ),
            ],
          ),
        ),
        body: TabBarView(children: [
          SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'email'),
                      validator: validateEmail,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(labelText: 'Password'),
                      validator: validatePassword,
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          FirebaseManager.login(
                              emailController.text, passwordController.text,
                              () {
                            Navigator.pushNamedAndRemoveUntil(context,
                                WalletScreen.routeName, (route) => false);
                          }, (e) {
                            return showDialog(
                                barrierDismissible: false,
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text("error"),
                                    content: const Text(
                                      "Wrong email or password",
                                    ),
                                    actions: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("ok"),
                                      )
                                    ],
                                  );
                                });
                          });
                        }
                      },
                      child: const Text('login'),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          SignUp()
        ]),
      ),
    );
  }

  String? validatePassword(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else {
      return null;
    }
  }

  String? validateEmail(value) {
    {
      if (value == null || value.isEmpty) {
        return 'Please enter your email';
      }
      final bool emailValid = RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
          .hasMatch(value);
      if (!emailValid) {
        return "please enter valid email";
      }
      return null;
    }
  }
}
