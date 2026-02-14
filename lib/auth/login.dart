import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:evently/firebase/firebase-function.dart';
import 'package:evently/home/home.dart';
import 'package:evently/auth/register.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/auth_provider.dart';
import 'forget_password_screen.dart';

class Login extends StatelessWidget {
  Login({super.key});

  var emailAddress = TextEditingController();
  var password = TextEditingController();
  var formKey = GlobalKey<FormState>();

  static const String routName = "Login";

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<AuthProvider>(context);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),

                Image.asset(
                  "assets/images/Blue White Minimal Modern Simple Bold Business Mag Logo 3.png",
                  height: 50,
                ),
                const SizedBox(height: 40),
                Text(
                  "Login to your account".tr(),
                  style: GoogleFonts.poppins(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 24),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Email address cannot be empty";
                    }
                    if (!value.contains('@')) {
                      return "Invalid Email format";
                    }
                    if (!value.contains('.com')) {
                      return "Invalid Email format";
                    }
                    return null;
                  },
                  controller: emailAddress,
                  decoration: InputDecoration(
                    errorStyle: const TextStyle(color: Colors.red),
                    hintText: "Enter your email".tr(),
                    hintStyle: TextStyle(color: Colors.grey),
                    prefixIcon: ImageIcon(AssetImage("assets/images/sms.png")),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password cannot be empty".tr();
                    }
                    if (value.length < 8) {
                      return "Password must be at least 8 characters long".tr();
                    }
                    if (!value.contains(RegExp(r'[A-Z]'))) {
                      return "Password must contain at least one capital letter".tr();
                    }
                    if (!value.contains(RegExp(r'[0-9]'))) {
                      return "Password must contain at least one number".tr();
                    }
                    return null;
                  },
                  controller: password,
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: "Enter your password".tr(),
                    errorStyle: const TextStyle(color: Colors.red),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Colors.red),
                    ),
                    hintStyle: const TextStyle(color: Colors.grey),
                    prefixIcon: const ImageIcon(
                      AssetImage("assets/images/lock.png"),
                    ),
                    suffixIcon: const ImageIcon(
                      AssetImage("assets/images/eye-slash.png"),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(color: Color(0xff7B7B7B)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                // Forget Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        ForgetPasswordScreen.routName,
                          arguments: emailAddress.text,

                      );
                  },

                      child: Text(
                      "Forget Password?".tr(),
                      style: GoogleFonts.inter(
                        color: Theme.of(context).colorScheme.secondary,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      FirebaseFunction.signUser(
                        emailAddress.text,
                        password.text,
                        () async {
                          provider.initUser();
                          await Future.delayed(Duration(seconds: 5));
                          Navigator.pushNamedAndRemoveUntil(
                            context,
                            Home.routName,
                                (route) => false,
                          );

                        },
                        (message) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(message)));
                          Navigator.pop(context);
                        },
                        () {
                          showDialog(
                            barrierDismissible: false,
                            context: context,
                            builder: (context) {
                              return Center(child: CircularProgressIndicator());
                            },
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.secondary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Text(
                    "Login".tr(),
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.onError,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don’t have an account ? ".tr()),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          Register.routName,
                        );
                      },
                      child: Text(
                        "Signup".tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                Row(
                  children: [
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        endIndent: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Text(
                      "Or".tr(),
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                    Expanded(
                      child: Divider(
                        thickness: 1,
                        indent: 20,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                OutlinedButton(
                  onPressed: () {
                    FirebaseFunction.signInWithGoogle(
                      onSuccess: (user) {
                        Navigator.pushNamedAndRemoveUntil(
                          context,
                          Home.routName,
                              (route) => false,
                        );
                      },
                      onError: (message) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(message)));
                      },
                    );
                  },
                  style: OutlinedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/google.png", height: 24),
                      const SizedBox(width: 10),
                      Text(
                        "Login with Google".tr(),
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.secondary,
                          fontSize: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
